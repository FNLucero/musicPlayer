//
//  AudioPlayerViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 05/11/2021.
//

import UIKit

class AudioPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label1 = UILabel()
        label1.text = "AudioPlayer"
        label1.font = UIFont.systemFont(ofSize: 30)
        label1.backgroundColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.5, alpha: 0.5)
        label1.autoresizingMask = .flexibleWidth
        label1.translatesAutoresizingMaskIntoConstraints = true
        label1.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 50)
        label1.textAlignment = .center
        self.view.addSubview(label1)
        
        let b1 = UIButton(type: .system)
        b1.setTitle("Play", for: .normal)
        b1.autoresizingMask = .flexibleWidth
        b1.translatesAutoresizingMaskIntoConstraints = true
        b1.frame = CGRect(x: 20, y: 100, width: 100, height: 40)
        self.view.addSubview(b1)
        
        let b2 = UIButton(type: .system)
        b2.setTitle("Stop", for: .normal)
        b2.autoresizingMask = .flexibleWidth
        b2.translatesAutoresizingMaskIntoConstraints = true
        b2.frame = CGRect(x: 250, y: 100, width: 100, height: 40)
        self.view.addSubview(b2)
        
        let s1 = UISlider()
        s1.autoresizingMask = .flexibleWidth
        s1.translatesAutoresizingMaskIntoConstraints = true
        s1.frame = CGRect(x: 20, y: 150, width: self.view.frame.width-40, height: 50)
        self.view.addSubview(s1)
        
        let labelVolumen = UILabel()
        labelVolumen.text = "Volumen"
        labelVolumen.font = UIFont.systemFont(ofSize: 14)
        //labelVolumen.backgroundColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.5, alpha: 0.5)
        labelVolumen.autoresizingMask = .flexibleWidth
        labelVolumen.translatesAutoresizingMaskIntoConstraints = true
        labelVolumen.frame = CGRect(x: 20, y: 200, width: self.view.frame.width, height: 50)
        //labelVolumen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        labelVolumen.textAlignment = .left
        self.view.addSubview(labelVolumen)
        
        let sVolumen = UISlider()
        sVolumen.autoresizingMask = .flexibleWidth
        sVolumen.translatesAutoresizingMaskIntoConstraints = true
        sVolumen.frame = CGRect(x: 20, y: 250, width: 200, height: 30)
        self.view.addSubview(sVolumen)
        
        /*
        //Image tiene que estar contenido en ImageView
        let iv = UIImageView()
        iv.autoresizingMask = .flexibleWidth
        iv.translatesAutoresizingMaskIntoConstraints = true
        iv.frame = CGRect(x: 20, y:300, width: 25, height: 25)
        iv.image = UIImage(named: "life") //nombre de imagen en el asset
        self.view.addSubview(iv)
         */
        
        let tf = UITextField()
        tf.frame = CGRect(x: 20, y: 300, width: 250, height: 45)
        self.view.addSubview(tf)
         
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
