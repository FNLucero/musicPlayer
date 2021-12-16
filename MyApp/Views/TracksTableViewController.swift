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
    let viewModel: TracksTableViewModel = TracksTableViewModel()
    
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
        timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true){ t in
            NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
        }
    }
    
    @objc func agregarCancionPorTimer(){
        viewModel.agregarCancionPorTimer()
        self.tableView.reloadData()
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
        
        viewModel.saveData()
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cantidadDeCanciones()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Casteo a tipo Paso 1, casteo con paso 1 aseguro que funciona
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        
        let elTrack = songList[indexPath.row]
        let claseCell = TrackTableViewCell(style: .default, reuseIdentifier: "reuseIdentifier", track: elTrack)
        
        claseCell.track = elTrack
        claseCell.parent = self as ButtonOnCellDelegate
        
        return claseCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
