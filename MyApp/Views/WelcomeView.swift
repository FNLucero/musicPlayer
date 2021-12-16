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
        
        agregarGestosImagen()
    }

    @IBAction func LogoutAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func agregarGestosImagen(){
        self.imagenLogo.isUserInteractionEnabled = true
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.imagenLogo.addGestureRecognizer(gestureTap)
        
        let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        self.imagenLogo.addGestureRecognizer(gesturePinch)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let compilado = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        
        showSimplePopUpAlert("INFO", "Version: \(version)\nCompilado: \(compilado)\n\(appName)")
    }
    
    @objc func didPinch(_ sender: UIPinchGestureRecognizer){
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
                   guard scale.a > 1.0 else { return }
                   guard scale.d > 1.0 else { return }
                    sender.view?.transform = scale
                   sender.scale = 1.0
        }
    }
}
