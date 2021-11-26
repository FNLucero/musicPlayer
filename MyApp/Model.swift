//
//  Model.swift
//  MyApp
//
//  Created by Facundo Lucero on 29/10/2021.
//

import Foundation

struct Account {
    let user: String
    let pass: String
}

struct Track: Codable {
    let title: String
    let artist: String?
    let album: String?
    let song_id: String
    var genre: GenerosMusicales?
    let duration: Double?
    
    let year: String?
    let coverImage: String?
    
    enum CodingKeys: String, CodingKey {
        case song_id
        case title
        case artist
        case album
        case genre
        case duration
        case year
        case coverImage
    }

}

enum GenerosMusicales: String, Codable{
    case Rock 
    case Pop
    case Jazz
    case Electro
    case vacion = ""
}

enum PlayerStates{
    case play
    case pause
    case next
    case previous
}



struct Registered {
    let user1: Account = Account(user: "facundolucero@gmail.com", pass: "contrasenia100")
}

var songList = [Track]()
/*
let songList: [Track] = [
    Track(title: "Century", artist: "Fall Out boy", album: "American Breaty", song_id: "1", genre: nil, duration: nil),
    Track(title: "Feel Good INC", artist: "Gorillaz", album: "Demon Days", song_id: "2", genre: nil, duration: nil),
    Track(title: "When The Sun Goes Down", artist: "Arctic Monkeys", album: "Single: When The Sun Goes Down", song_id: "3", genre: nil, duration: nil),
    Track(title: "Bridge Burning", artist: "Foo Fighters", album: "Wasting Lights", song_id: "4", genre: nil, duration: nil),
    Track(title: "Beggin", artist: "Maneskin", album: "Chosen", song_id: "5", genre: nil, duration: nil),
    Track(title: "Radioactive", artist: "Imagine Dragons", album: "Night Visions", song_id: "6", genre: nil, duration: nil),
    Track(title: "Do You Want To", artist: "Franz Fernidand", album: "You Could Have It So Much Better", song_id: "7", genre: nil, duration: nil),
    ]
*/
/*
let trackElementList: [TrackTableViewCell] = [
    TrackTableViewCell( track: [1: Track(title: "Century", artist: "Fall Out boy", album: "American Breaty")] ),
    TrackTableViewCell( track: [2: Track(title: "Feel Good INC", artist: "Gorillaz", album: "Demon Days")] ),
    TrackTableViewCell( track: [3: Track(title: "When The Sun Goes Down", artist: "Arctic Monkeys", album: "Single: When The Sun Goes Down")] ),
    TrackTableViewCell( track: [4: Track(title: "Bridge Burning", artist: "Foo Fighters", album: "Wasting Lights")] ),
    TrackTableViewCell( track: [5: Track(title: "Beggin", artist: "Maneskin", album: "Chosen")] ),
    TrackTableViewCell( track: [6: Track(title: "Radioactive", artist: "Imagine Dragons", album: "Night Visions")] ),
    TrackTableViewCell( track: [7: Track(title: "Do You Want To", artist: "Franz Fernidand", album: "You Could Have It So Much Better")] )
]
*/

/*
var trackElement: TrackTableViewCell = TrackTableViewCell( track: [1: Track(title: "Century", artist: "Fall Out boy", album: "American Breaty")] )*/

