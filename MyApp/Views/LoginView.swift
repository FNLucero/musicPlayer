//
//  ViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 22/10/2021.
//

import UIKit
//Vista
class ViewController: UIViewController {

    var viewModel: LoginViewModel = LoginViewModel()
    
    @IBOutlet weak var labelLogIn: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        view.backgroundColor = UIColor(named: "ColorPrincipal")
        labelEmail.textColor = UIColor(named: "ColorSecundario")
        labelLogIn.textColor = UIColor(named: "ColorSecundario")
        labelPassword.textColor = UIColor(named: "ColorSecundario")
    }

    @IBAction func `continue`(_ sender: Any) {
        print(#function)
        if viewModel.validateLogin(username: username.text, pass: password.text){
            goToMainController()
        }
        else {
            username.text = ""
            password.text = ""
            username.errorAnimated()
            password.errorAnimated()
            self.showSimpleAlert("Usuario invalido: Codigo de error \(viewModel.tipoError), \(viewModel.messageDescription)")
        }
        
    }
    
    @IBAction func singUp(_ sender: Any) {
        print(#function)
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
