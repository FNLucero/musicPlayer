//
//  TrackTableViewModel.swift
//  MyApp
//
//  Created by Facundo Lucero on 16/12/2021.
//

import Foundation
import UIKit
import CoreData

class TracksTableViewModel {
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
        if APIManager().checkConnectivity() {
        //if false{
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
            }
        }
    }
    
    func agregarCancionPorTimer(){
        let cancion: Track = Track(title: "Bridge Burning", artist: "Foo Fighters", album: "Wasting Lights", song_id: "56", genre: nil, year: nil, coverImage: nil) //duration: nil,
        
        if (!songList.contains{$0.title == "Bridge Burning"}){
            songList.append(cancion)
        }
    }
    
    func cantidadDeCanciones() -> Int {
        return songList.count
    }
}
