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
    
    let buttonPlay = UIButton(type: .system)
    let buttonStop = UIButton(type: .system)
    
    var song: Sound?
    var timer: Timer?
    
    var imageViewGif: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ColorPrincipal")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSongSlider), userInfo: nil, repeats: true)
        
        labelTitulo.text = "AudioPlayer"
        labelTitulo.font = UIFont.systemFont(ofSize: 24)
        labelTitulo.backgroundColor = UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.5, alpha: 0.3)
        labelTitulo.autoresizingMask = .flexibleWidth
        labelTitulo.translatesAutoresizingMaskIntoConstraints = true
        labelTitulo.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 50)
        labelTitulo.textAlignment = .center
        self.view.addSubview(labelTitulo)
        
        
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.autoresizingMask = .flexibleWidth
        buttonPlay.translatesAutoresizingMaskIntoConstraints = true
        buttonPlay.frame = CGRect(x: 20, y: 100, width: 100, height: 40)
        self.view.addSubview(buttonPlay)
        buttonPlay.addTarget(self, action: #selector(botonTouchPlay), for: .touchUpInside)
        /*
        buttonPlay.setTitle("Play", for: .normal)
        buttonPlay.autoresizingMask = .flexibleWidth
        buttonPlay.translatesAutoresizingMaskIntoConstraints = true
        //buttonPlay.frame = CGRect(x: 20, y: 100, width: 100, height: 40)
        self.view.addSubview(buttonPlay)
        buttonPlay.addTarget(self, action: #selector(botonTouchPlay), for: .touchUpInside)
        
        self.view.addSubview(buttonPlay)
        NSLayoutConstraint.activate([
            buttonPlay.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            //buttonPlay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            buttonPlay.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            buttonPlay.widthAnchor.constraint(equalTo: buttonPlay.heightAnchor)
        ])*/
        
        
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
        sliderVolume.addTarget(self, action: #selector(slideVolumenChange), for: .valueChanged)
        
        enableGif()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let fileSongURL = Bundle.main.url(forResource: "bensound-ukulele", withExtension: ".mp3") else{
            return
        }
        Sound.enabled = true
        song = Sound(url: fileSongURL)
        song?.volume = 1
        song?.play()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print(#function)
        self.isPlaying = !(self.isPlaying)
        print("la variable is Playing esta en \(isPlaying)")
        if self.isPlaying {
            playSong()
        }
        else {
            stopSong()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
        labelTitulo.text = songTitle
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        song?.stop()
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
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
    
    func playSong(){
        enableGif()
        song?.resume()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSongSlider), userInfo: nil, repeats: true)
    }
    
    func stopSong(){
        disableGif()
        song?.pause()
        timer?.invalidate()
        timer = nil
    }
    
    @objc func botonTouchPlay(){
        playSong()
    }
    
    @objc func botonTouchPause(){
        stopSong()
    }
    
    @objc func slideVolumenChange(){
        song?.volume = sliderVolume.value
    }
    
    @objc func updateSongSlider(){
        let porcentual: Double =  ( 1.0  / (song!.duration) )
        sliderTrack.value += Float (porcentual)
        if(sliderTrack.value == 1){
            disableGif()
        }
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
