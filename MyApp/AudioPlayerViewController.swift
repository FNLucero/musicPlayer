//
//  AudioPlayerViewController.swift
//  MyApp
//
//  Created by Facundo Lucero on 05/11/2021.
//

import UIKit
import AudioPlayer

class AudioPlayerViewController: UIViewController {

    var isPlaying: Bool = true
    var songTitle: String?
    let labelTitulo = UILabel()
    let sliderTrack = UISlider()
    let sliderVolume = UISlider()
    
    let buttonPlay = UIButton(type: .system)
    let buttonStop = UIButton(type: .system)
    
    var song: AudioPlayer?
    var timer: Timer?
    
    var imageViewGif: UIImageView?
    
    var porcentualCancion: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ColorPrincipal")
        
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
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonPlay)
        buttonPlay.addTarget(self, action: #selector(botonTouchPlay), for: .touchUpInside)
        
        self.view.addSubview(buttonPlay)
        NSLayoutConstraint.activate([
            buttonPlay.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            buttonPlay.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonPlay.widthAnchor.constraint(equalTo: buttonPlay.heightAnchor)
        ])
        
        buttonStop.setTitle("Stop", for: .normal)
        buttonStop.autoresizingMask = .flexibleWidth
        buttonStop.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonStop)
        buttonStop.addTarget(self, action: #selector(botonTouchPause), for: .touchUpInside)
        
        self.view.addSubview(buttonStop)
        NSLayoutConstraint.activate([
            buttonStop.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            buttonStop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStop.widthAnchor.constraint(equalTo: buttonStop.heightAnchor)
        ])
        
        sliderTrack.autoresizingMask = .flexibleWidth
        sliderTrack.translatesAutoresizingMaskIntoConstraints = true
        sliderTrack.frame = CGRect(x: 20, y: 150, width: self.view.frame.width-40, height: 50)
        self.view.addSubview(sliderTrack)
        sliderTrack.addTarget(self, action: #selector(slideTrackChange), for: .valueChanged)
        
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
        do{
            song = try AudioPlayer(fileName: "bensound-ukulele.mp3")
            song?.play()
            song?.volume = 1.0
            porcentualCancion = ( 1.0  / Double(song!.duration) )
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSongSlider), userInfo: nil, repeats: true)
        }
        catch{
            print("El sonido ha fallado en inicializar")
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print(#function)
        if !self.isPlaying {
            playSong()
        }
        else {
            stopSong()
        }
        print("la variable is Playing esta en \(isPlaying)")
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
        isPlaying = true
        enableGif()
        song?.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSongSlider), userInfo: nil, repeats: true)
    }
    
    func stopSong(){
        isPlaying = false
        disableGif()
        song?.stop()
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
    
    @objc func slideTrackChange(sender: UISlider){
        stopSong()
        let posicionActual: Double = Double(sliderTrack.value)
        let tiempoActualizado = Double(song!.duration) * posicionActual
        song?.currentTime = TimeInterval( tiempoActualizado )
        playSong()
    }
    
    
    @objc func updateSongSlider(){
        sliderTrack.value += Float (porcentualCancion!)
        if(sliderTrack.value == 1.0){
            stopSong()
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


