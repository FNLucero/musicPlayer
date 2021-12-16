//
//  DataManager.swift
//  MyApp
//
//  Created by Facundo Lucero on 18/11/2021.
//

import Foundation

class DataManager{
    static func cancionesPorGenero(songs: [Track]) -> [Track]{
        return songs.filter{ song in song.genre != nil }
    }
}
