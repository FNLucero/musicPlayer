//
//  WelcomeViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 29/10/2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var imagenLogo: UIImageView!
    @IBOutlet weak var labelBienvenido: UILabel!
    
    @IBOutlet weak var LogOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "ColorPrincipal")
        labelBienvenido.textColor = UIColor(named: "ColorSecundario")
        imagenLogo.image = UIImage(systemName: "person.fill")
    }

    @IBAction func LogoutAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
