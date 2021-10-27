//
//  RegisterViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 27/10/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        print(#function)
        /*
        if let user = email{
            let emailText = (self.email.text)!
            let resultToValidateEmail = validateTheLargeOfTextField(value: emailText)
            

            print("Resultados user \(resultToValidateEmail)")
            
            resultToValidateEmail ? print("Email registrado") : print("email invalido")
            
        }*/
        let emailText = self.email.text
        
        let resultToValidatemail = validateTheLargeOfTextField(value: emailText!)
        
        resultToValidatemail ? print("Email Valido") : print("Email invalido")
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        print(#function)
    }
    
    
    @IBAction func singUpWithFacebook(_ sender: Any) {
        print(#function)
    }
    
    
    func validateTheLargeOfTextField(value text: String)-> Bool{
        return text != "" && text.count > 10 ? true : false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
