//
//  PlayListDetailViewModel.swift
//  MyApp
//
//  Created by Facundo Lucero on 16/12/2021.
//

import Foundation

class PlayListDetailViewModel {
    
    var playList : [Track] = []
    var tracksArray = [Track]()
    
    func countOfLines() -> Int{
        return tracksArray.count
    }
    
    func trackArrayIndex(_ index: Int) -> Track{
        return tracksArray[index]
    }
    
    func doesntContentElement(_ cancion: Track) -> Bool{
        return playList.contains{titulo in
            titulo.title == cancion.title
        }
    }
    
    func addTrack(_ track: Track) {
        playList.append(track)
        tracksArray = playList
    }
}
