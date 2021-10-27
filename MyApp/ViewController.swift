//
//  ViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 22/10/2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#function)
    }


    @IBAction func `continue`(_ sender: Any) {
        print(#function)
        
        let user = self.username.text
        let pass = self.password.text
        
        /*if let user = username, let pass = password{
            let userText = (self.username.text)!
            let resultToValidateUser = validateTheLargeOfTextField(value: userText)
            
            let passText = (self.password.text)!
            let resultToValidatePass = validateTheLargeOfTextField(value: passText)
            
            print("Resultados user \(resultToValidateUser) y pass \(resultToValidatePass)")
            
         resultToValidateUser && resultToValidatePass ? print("Autenticar usuario") : print("usuario invalido")
            
        }*/
        let resultToValidateUser = validateTheLargeOfTextField(value: user!)
        let resultToValidatePass = validateTheLargeOfTextField(value: pass!)
        resultToValidateUser && resultToValidatePass ? print("Autenticar usuario") : print("usuario invalido")
        
    }
    
    func validateTheLargeOfTextField(value text: String)-> Bool{
        return text != "" && text.count > 10 ? true : false
    }
    
    
    @IBAction func singUp(_ sender: Any) {
        print(#function)
    }
}

