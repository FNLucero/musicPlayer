//
//  ViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 22/10/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelLogIn: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var tipoError: Int = 0
    let registros = Registered()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        view.backgroundColor = UIColor(named: "ColorPrincipal")
        labelEmail.textColor = UIColor(named: "ColorSecundario")
        labelLogIn.textColor = UIColor(named: "ColorSecundario")
    }

    @IBAction func `continue`(_ sender: Any) {
        print(#function)
        validateTextfieldsAndCorrectLogin() ? goToMainController() : print("Usuario invalido: Codigo de error \(tipoError)")
    }
    
    @IBAction func singUp(_ sender: Any) {
        print(#function)
    }
    
    /**
        Esta funcion se encarga de validar todos los textfields de la vista Login, asignandole un numero de error a la propiedad tipoError
        y devolviendo un booleano, el cual es resultado de la validacion y contenido del user y pass
     */
    func validateTextfieldsAndCorrectLogin()-> Bool{
        guard let userString = username.text, userString.count > 0 else{
            print("Email sin contenido")
            tipoError = 1
            return false
        }
        guard userString.contains("@"), userString.count >= 10 else{
            print("El email no tiene @ o tiene menos de 10 caracteres")
            tipoError = 2
            return false
        }
        
        guard let passString = password.text, passString.count > 0 else{
            print("Password sin contenido")
            tipoError = 3
            return false
        }
        guard passString.count >= 10 else{
            print("Password con menos de 10 caracteres")
            tipoError = 4
            return false
        }
        let resultadoValidacion: Bool = validateEmailAndPass(userText: userString, passText: passString)
        resultadoValidacion ? print("Usuario validad") : print("Usuario o contraseña incorrecta")
        return resultadoValidacion
    }
    
    func validateEmailAndPass(userText: String, passText: String)-> Bool{
        return (registros.user1.user == userText && registros.user1.pass == passText) ? true : false
    }
    
    
    func goToMainController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainViewController") as? WelcomeViewController
          vc?.modalPresentationStyle = .fullScreen
        guard let vc = vc else { return }
        
        self.present(vc, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
