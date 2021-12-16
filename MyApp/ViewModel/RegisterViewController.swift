//
//  RegisterViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 16/12/2021.
//

import Foundation

class RegisterViewController {
    /**
        Esta funcion se encarga de validar todos los textfields de la vista SignUp, asignandole un numero de error a la propiedad tipoError
        y devolviendo un booleano, el cual es resultado de la validacion
     */
    func validateTextfields(_ mail: String?)-> Bool{
        guard let emailString = mail, emailString.count > 0 else{
            print("Email sin contenido Error de tipo 1")
            return false
        }
        guard emailString.isValidEmail(), emailString.count >= 10 else{
            print("El email no tiene @ o tiene menos de 10 caracteres, error tipo 2")
            return false
        }
        return true
    }
}
