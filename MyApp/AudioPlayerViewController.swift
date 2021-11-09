//
//  AudioPlayerViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 05/11/2021.
//

import UIKit

class AudioPlayerViewController: UIViewController {

    var isPlaying: Bool = false
    var songTitle: String?
    let labelTitulo = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitulo.text = "AudioPlayer"
        labelTitulo.font = UIFont.systemFont(ofSize: 30)
        labelTitulo.backgroundColor = UIColor(displayP3Red: 0.0, green: 1.0, blue: 0.5, alpha: 0.5)
        labelTitulo.autoresizingMask = .flexibleWidth
        labelTitulo.translatesAutoresizingMaskIntoConstraints = true
        labelTitulo.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 50)
        labelTitulo.textAlignment = .center
        self.view.addSubview(labelTitulo)
        
        let buttonPlay = UIButton(type: .system)
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.autoresizingMask = .flexibleWidth
        buttonPlay.translatesAutoresizingMaskIntoConstraints = true
        buttonPlay.frame = CGRect(x: 20, y: 100, width: 100, height: 40)
        self.view.addSubview(buttonPlay)
        
        let buttonStop = UIButton(type: .system)
        buttonStop.setTitle("Stop", for: .normal)
        buttonStop.autoresizingMask = .flexibleWidth
        buttonStop.translatesAutoresizingMaskIntoConstraints = true
        buttonStop.frame = CGRect(x: 250, y: 100, width: 100, height: 40)
        self.view.addSubview(buttonStop)
        
        let sliderTrack = UISlider()
        sliderTrack.autoresizingMask = .flexibleWidth
        sliderTrack.translatesAutoresizingMaskIntoConstraints = true
        sliderTrack.frame = CGRect(x: 20, y: 150, width: self.view.frame.width-40, height: 50)
        self.view.addSubview(sliderTrack)
        
        let labelVolumen = UILabel()
        labelVolumen.text = "Volumen"
        labelVolumen.font = UIFont.systemFont(ofSize: 14)
        labelVolumen.autoresizingMask = .flexibleWidth
        labelVolumen.translatesAutoresizingMaskIntoConstraints = true
        labelVolumen.frame = CGRect(x: 20, y: 200, width: self.view.frame.width, height: 50)
        labelVolumen.textAlignment = .left
        self.view.addSubview(labelVolumen)
        
        let sliderVolume = UISlider()
        sliderVolume.autoresizingMask = .flexibleWidth
        sliderVolume.translatesAutoresizingMaskIntoConstraints = true
        sliderVolume.frame = CGRect(x: 20, y: 250, width: 200, height: 30)
        self.view.addSubview(sliderVolume)
        
        let tf = UITextField()
        tf.frame = CGRect(x: 20, y: 300, width: 250, height: 45)
        self.view.addSubview(tf)
         
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print(#function)
        self.isPlaying = !(self.isPlaying)
        print("la variable is Playing esta en \(isPlaying)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelTitulo.text = songTitle
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
