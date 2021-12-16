//
//  Extensions.swift
//  MyApp
//
//  Created by Facundo Lucero on 06/12/2021.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let regExp = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$", options: [])
        let coincidencias = regExp.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        
        return coincidencias.count > 0 ? true : false
    }
}

extension UIViewController {
    func showSimpleAlert(_ mensaje:String) {
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func showSimplePopUpAlert(_ titulo: String, _ mensaje: String) {
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
