//
//  TracksTableViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 03/11/2021.
//

import UIKit
import CoreData

class TracksTableViewController: UITableViewController, ButtonOnCellDelegate {
    
    var songTitle: String?
    var songTrack: Track?
    var buttonPlay: PlayStopButton?
    
    var timer: Timer?
    
    func buttonTouchedOnCell(cell: UITableViewCell) {
        let vc = AudioPlayerViewController()
        vc.songTrack = self.songTrack!
        vc.tableView = self.tableView
        vc.cellButton = buttonPlay
        self.present(vc,animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        NotificationCenter.default.addObserver(self, selector: #selector(agregarCancionPorTimer), name: NSNotification.Name("updateTable"), object: nil)
        
        //IMPORTANTE
        //Indica al tableView de que tipo de celda va a mostrar -- Paso 1
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(agregarCancionPorTimer), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true){ t in
            NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
        }
    }
    
    @objc func agregarCancionPorTimer(){
        let cancion: Track = Track(title: "Bridge Burning", artist: "Foo Fighters", album: "Wasting Lights", song_id: "56", genre: nil, year: nil, coverImage: nil) //duration: nil,
        
        if (!songList.contains{$0.title == "Bridge Burning"}){
            songList.append(cancion)
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
         let callBack: ( [Track]?, Error? ) -> () = { canciones, error in
         if error != nil {
         print("No se pudo obtener la lista de canciones")
         }
         else {
         songList = canciones ?? []
         DispatchQueue.main.async {
         self.tableView.reloadData()
         }
         }
         }
         let api = APIManager()
         api.getMusic(completion: callBack)*/
        
        self.saveData()
        
        
    }
    
    func saveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        
        let request =  NSFetchRequest<NSFetchRequestResult>(entityName: "Tracks")
        request.returnsObjectsAsFaults = false
        do{
            let result = try context!.fetch(request)
            songList = [Track]()
            
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as? String
                let artist = data.value(forKey: "artist") as? String
                let album = data.value(forKey: "album") as? String
                let coverImage = data.value(forKey: "cover_image") as? String
                //let genre = data.value(forKey: "genre") as? String
                let songId = data.value(forKey: "song_id") as? String
                let year = data.value(forKey: "year") as? String
                
                let track = Track( title: title ?? "", artist: artist ?? "", album: album ?? "No especificado", song_id: songId ?? "", genre: nil, year: year ?? "", coverImage: coverImage ?? "")
                
                songList.append(track)
            }
        }
        catch{
            print("Falle al obtener info en la BD, \(error), \(error.localizedDescription)")
        }
        
        //Consigna de tener internet en un if
        if APIManager().checkConnectivity(){
            self.downloadTracks()
        }
    }
    
    func downloadTracks(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        
        RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in
            songList = [Track]()
            
            //Usamos coreData
            if let _data = data {
                songList = _data
                
                if let _context = context{
                    
                    //Eliminar contenido
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tracks")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    
                    do{
                        try  appDelegate.persistentStoreCoordinator?.execute(deleteRequest, with: _context)
                    }
                    catch{
                        print(error)
                    }
                    //FIN eliminar contenido
                    //===================================
                    //Se agrega info
                    for item in _data {
                        guard let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "Tracks", into: _context) as? NSManagedObject else {return}
                        tracksEntity.setValue(item.artist, forKey: "artist")
                        tracksEntity.setValue(item.album, forKey: "album")
                        tracksEntity.setValue(item.coverImage, forKey: "cover_image")
                        tracksEntity.setValue(item.genre?.rawValue, forKey: "genre")
                        tracksEntity.setValue(item.song_id, forKey: "song_id")
                        tracksEntity.setValue(item.title, forKey: "title")
                        tracksEntity.setValue(item.year, forKey: "year")
                        
                        do{
                            try _context.save()
                        }
                        catch{
                            print("No se guardo la info. \(error), \(error.localizedDescription)")
                        }
                    }
                    
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Casteo a tipo Paso 1, casteo con paso 1 aseguro que funciona
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        
        let elTrack = songList[indexPath.row]
        let claseCell = TrackTableViewCell(style: .default, reuseIdentifier: "reuseIdentifier", track: elTrack)
        
        //cell.track = elTrack
        //cell.parent = self
        
        claseCell.track = elTrack
        claseCell.parent = self as ButtonOnCellDelegate
        
        return claseCell
        //return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
