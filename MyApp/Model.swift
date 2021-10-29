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


struct Registered {
    let user1: Account = Account(user: "facundolucero@gmail.com", pass: "contrasenia100")
}
