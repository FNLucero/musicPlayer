//
//  LoginViewModel.swift
//  MyApp
//
//  Created by Facundo Lucero on 01/12/2021.
//

import Foundation

class LoginViewModel {
    var model: Registered = Registered()
    var tipoError: Int = 0
    var messageDescription: String = ""
    /**
    Esta funcion se encarga de validar todos los textfields de la vista Login, asignandole un numero de error a la propiedad tipoError
    y devolviendo un booleano, el cual es resultado de la validacion y contenido del user y pass
     - Parameter: userText: Email a validar
     - Parameter: passText: Contraseña a validar
     */
    func validateEmailAndPass(userText: String, passText: String)-> Bool{
        return (model.user1.user == userText && model.user1.pass == passText)
    }
    
    /**
    Esta funcion se encarga de validar todos los textfields de la vista Login, asignandole un numero de error a la propiedad tipoError
    y devolviendo un booleano, el cual es resultado de la validacion y contenido del user y pass
     */
    func validateLogin(username: String?, pass: String?)-> Bool{
        guard let userString = username, userString.count > 0 else{
            messageDescription = "Email sin contenido"
            tipoError = 1
            return false
        }
        guard userString.isValidEmail(), userString.count >= 10 else{
            messageDescription = "El email no tiene el formato correcto"
            tipoError = 2
            return false
        }
        
        guard let passString = pass, passString.count > 0 else{
            messageDescription = "Password sin contenido"
            tipoError = 3
            return false
        }
        guard passString.count >= 10 else{
            messageDescription = "Password con menos de 10 caracteres"
            tipoError = 4
            return false
        }
        let resultadoValidacion: Bool = validateEmailAndPass(userText: userString, passText: passString)
        
        messageDescription = resultadoValidacion ? "Usuario validad" : "Usuario o contraseña incorrecta"
        
        print(messageDescription)
        
        return resultadoValidacion
    }
    
    func getErrorDescription() -> String{
        return self.messageDescription
    }
}
