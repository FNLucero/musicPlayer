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

struct Track {
    let title: String
    let artist: String
    let album: String
}

struct Registered {
    let user1: Account = Account(user: "facundolucero@gmail.com", pass: "contrasenia100")
}


let songList: [Track] = [
    Track(title: "Century", artist: "Fall Out boy", album: "American Breaty"),
    Track(title: "Feel Good INC", artist: "Gorillaz", album: "Demon Days"),
    Track(title: "When The Sun Goes Down", artist: "Arctic Monkeys", album: "Single: When The Sun Goes Down"),
    Track(title: "Bridge Burning", artist: "Foo Fighters", album: "Wasting Lights"),
    Track(title: "Beggin", artist: "Maneskin", album: "Chosen"),
    Track(title: "Radioactive", artist: "Imagine Dragons", album: "Night Visions"),
    Track(title: "Do You Want To", artist: "Franz Fernidand", album: "You Could Have It So Much Better"),
    ]

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

