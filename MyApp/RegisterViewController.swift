//
//  RegisterViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 27/10/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var labelSignUpWithSN: UILabel!
    @IBOutlet weak var labelEmailRegister: UILabel!
    @IBOutlet weak var labelSingUp: UILabel!
    
    var tipoError: Int = 0
    var identificadorColor: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        view.backgroundColor = UIColor(named: "ColorPrincipal")
        labelSignUpWithSN.textColor = UIColor(named: "ColorSecundario")
        labelEmailRegister.textColor = UIColor(named: "ColorSecundario")
        labelSingUp.textColor = UIColor(named: "ColorSecundario")
    }
    
    @IBAction func register(_ sender: Any) {
        print(#function)
        
        if validateTextfields() {
            print("Email valido")
            goToMainController()
        }
        else{
            email.text = ""
            email.errorAnimated()
            print("Usuario invalido: Codigo de error \(tipoError)")
        }
        
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        print(#function)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func singUpWithFacebook(_ sender: Any) {
        print(#function)
        identificadorColor = identificadorColor == 3 ? 1 : identificadorColor + 1
        labelSignUpWithSN.textColor = UIColor(named: "Color-\(identificadorColor)")
    }
    
    
    /**
        Esta funcion se encarga de validar todos los textfields de la vista SignUp, asignandole un numero de error a la propiedad tipoError
        y devolviendo un booleano, el cual es resultado de la validacion
     */
    func validateTextfields()-> Bool{
        guard let emailString = email.text, emailString.count > 0 else{
            print("Email sin contenido")
            tipoError = 1
            return false
        }
        guard emailString.isValidEmail(), emailString.count >= 10 else{
            print("El email no tiene @ o tiene menos de 10 caracteres")
            tipoError = 2
            return false
        }
        return true
    }
    
    /**
     Funcion que direcciona a MainController
     */
    func goToMainController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InicioTabBarViewController") as? UITabBarController
          vc?.modalPresentationStyle = .fullScreen
        guard let vc = vc else { return }
        self.present(vc, animated: true)
    }
    
    /**
     Funcion que minimiza el teclado en caso de tocar la pantalla
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
