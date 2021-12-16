//
//  AudioPlayerViewModel.swift
//  MyApp
//
//  Created by Facundo Lucero on 16/12/2021.
//

import Foundation
import AudioPlayer

class AudioPlayerViewModel: UIViewController {
    
    var songTrack: Track?
    
    func addMenuItems() -> UIMenu{
        let actionsDictionary = [BtnOpciones.trash: eliminar, BtnOpciones.download: descargar, BtnOpciones.addPlaylist: agregarAPlaylist, BtnOpciones.share: compartir]

        var items = [UIAction]()
        
        for opcion in BtnOpciones.allCases {
            items.append(.init(title: opcion.title, image: opcion.imagen, handler: {_ in
                actionsDictionary[opcion]?()
            }))
        }
        return .init(title: "", image: nil, children: items)
    }
    
    func eliminar() -> Void {
        let cancionABorrar = songList.firstIndex(where: {$0.title == self.songTrack!.title})
        songList.remove(at : cancionABorrar!)
        self.showSimplePopUpAlert("Borrado","Se ha borrado la cancion \(self.songTrack?.title ?? "")")
        print("Delete")
    }
    
    func descargar() -> Void {
        DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
        self.showSimplePopUpAlert("Descarga","Se ha comenzado a descargar \(self.songTrack?.title ?? "")")
    }
    
    func agregarAPlaylist() -> Void {
        playlistSongs.append(songTrack!)
        self.showSimplePopUpAlert("Favoritos","Se ha agregado a favoritos: \(self.songTrack?.title ?? "")")
    }
    
    func compartir() -> Void {
        let shareMenu = UIActivityViewController(activityItems: [""], applicationActivities: nil)
        shareMenu.popoverPresentationController?.sourceView = self.view
        self.present(shareMenu, animated: true)
        print("Share song")
    }
}
