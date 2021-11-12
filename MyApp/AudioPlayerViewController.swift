//
//  AudioPlayerViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 05/11/2021.
//

import UIKit
import SwiftySound

class AudioPlayerViewController: UIViewController {

    var isPlaying: Bool = true
    var songTitle: String?
    let labelTitulo = UILabel()
    let sliderTrack = UISlider()
    let sliderVolume = UISlider()
    var song: Sound?
    
    var imageViewGif: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        labelTitulo.text = "AudioPlayer"
        labelTitulo.font = UIFont.systemFont(ofSize: 30)
        labelTitulo.backgroundColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.5, alpha: 0.3)
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
        buttonPlay.addTarget(self, action: #selector(botonTouchPlay), for: .touchUpInside)
        
        let buttonStop = UIButton(type: .system)
        buttonStop.setTitle("Stop", for: .normal)
        buttonStop.autoresizingMask = .flexibleWidth
        buttonStop.translatesAutoresizingMaskIntoConstraints = true
        buttonStop.frame = CGRect(x: self.view.frame.width-120, y: 100, width: 100, height: 40)
        self.view.addSubview(buttonStop)
        buttonStop.addTarget(self, action: #selector(botonTouchPause), for: .touchUpInside)
        
        sliderTrack.autoresizingMask = .flexibleWidth
        sliderTrack.translatesAutoresizingMaskIntoConstraints = true
        sliderTrack.frame = CGRect(x: 20, y: 150, width: self.view.frame.width-40, height: 50)
        self.view.addSubview(sliderTrack)
        
        let labelVolumen = UILabel()
        labelVolumen.text = "Volumen"
        labelVolumen.font = UIFont.systemFont(ofSize: 14)
        labelVolumen.autoresizingMask = .flexibleWidth
        labelVolumen.translatesAutoresizingMaskIntoConstraints = true
        labelVolumen.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 50)
        labelVolumen.textAlignment = .center
        self.view.addSubview(labelVolumen)
        
        sliderVolume.autoresizingMask = .flexibleWidth
        sliderVolume.translatesAutoresizingMaskIntoConstraints = true
        sliderVolume.frame = CGRect(x: 20, y: 250, width: self.view.frame.width - 40, height: 30)
        sliderVolume.value = 1
        self.view.addSubview(sliderVolume)
        
        enableGif()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let fileSongURL = Bundle.main.url(forResource: "bensound-ukulele", withExtension: ".mp3") else{
            return
        }
        Sound.enabled = true
        song = Sound(url: fileSongURL)
        song?.volume = sliderVolume.value
        song?.play()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            imageViewGif!.frame=CGRect(x: 0, y: 300, width: self.view.frame.width, height: 150)
        } else {
            print("Portrait")
            imageViewGif!.frame=CGRect(x: 0, y: 300, width: self.view.frame.width, height: 150)
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print(#function)
        self.isPlaying = !(self.isPlaying)
        print("la variable is Playing esta en \(isPlaying)")
        if self.isPlaying {
            enableGif()
            song?.resume()
        }
        else {
            disableGif()
            song?.pause()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelTitulo.text = songTitle
    }
    
    func enableGif(){
        guard let fileGIFURL = Bundle.main.url(forResource: "stegosaurus-studio", withExtension: ".gif") else{
            return
        }
        let gifImage = UIImage.animatedImage(withAnimatedGIFURL: fileGIFURL)
        imageViewGif = UIImageView(image: gifImage)
        imageViewGif!.autoresizingMask = .flexibleWidth
        imageViewGif!.translatesAutoresizingMaskIntoConstraints=true
        imageViewGif!.frame=CGRect(x: 0, y: 300, width: self.view.frame.width, height: 150)
        self.view.addSubview(imageViewGif!)
    }
    
    func disableGif(){
        imageViewGif!.image = UIImage(named: "stopedGif")
    }
    
    @objc func botonTouchPlay(){
        enableGif()
        song?.resume()
    }
    
    @objc func botonTouchPause(){
        disableGif()
        song?.pause()
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
