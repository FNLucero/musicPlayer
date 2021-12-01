//
//  PlayButton.swift
//  MyApp
//
//  Created by Facundo Lucero on 23/11/2021.
//

import UIKit

/*
class PlayStopButton: UIButton {
    var icon: UIImage?
    var secondIcon: UIImage?
    var isPlaying: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.tintColor = .systemGreen
    }
    
    func performTwoStateSelection() {
        self.isPlaying = !isPlaying
        print (isPlaying)
        self.setImage(isPlaying ? icon : secondIcon, for: .normal)
        self.setImage(isPlaying ? icon : secondIcon, for: .highlighted)
    }
    
    func setImage(icon: UIImage?) {
        guard let icon = icon else { return }
        self.icon = icon
        self.setImage(icon, for: .normal)
        self.setImage(icon, for: .highlighted)
    }
}
 */

class PlayStopButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw( rect: CGRect) {
        // Drawing code
    }
    */
    var icon : UIImage?
    var pauseIcon : UIImage?
    var playIcon : UIImage?
    var isPlaying : Bool = false

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.tintColor = .white
    }

    func performTwoStateSelection () {
        print("el contenido del boton es \(self.isPlaying)")
        self.isPlaying = !isPlaying
        
        print("el contenido del boton es \(self.isPlaying)")
        print("-------------------------------------------")

        self.setImage( isPlaying ? pauseIcon : playIcon, for: .normal)
        self.setImage( isPlaying ? pauseIcon : playIcon, for: .highlighted)
        //self.setImage( isPlaying ? icon : secondIcon, for: .normal)
    }

    func setImage(icon : UIImage?) {
        guard let icon = icon else { return }
        self.icon = icon
        self.setImage(icon, for: .normal)
        self.setImage(icon, for: .highlighted)
    }
//--------------------
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitleColor(.red, for: .highlighted)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = .green
            }
            else {
                backgroundColor = UIColor(displayP3Red: 0.6, green: 0, blue: 0, alpha: 0.56)
            }
            super.isHighlighted = newValue
        }
    }
}
