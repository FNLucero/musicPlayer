//
//  TrackTableViewCell.swift
//  MyApp
//
//  Created by Facundo Lucero on 05/11/2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    var track: Track?
    var parent: ButtonOnCellDelegate?
    
    var labelTitulo = UILabel()
    var labelAlbum = UILabel()
    var buttonPlay = UIButton(type: .custom)
    var imageViewAlbum = UIImageView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, track: Track?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.track = track
        
        self.backgroundColor = UIColor.black
                
        initializeComponents()

        buttonPlay.addTarget(self, action: #selector(botonTouchFuncion), for: .touchUpInside)
        

    }
    
    @objc func botonTouchFuncion(){
        if self.parent != nil {
            parent!.buttonTouchedOnCell(cell: self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeComponents() {
        labelTitulo.text = self.track!.title
        labelTitulo.font = UIFont.systemFont(ofSize: 10)
        labelTitulo.textColor = UIColor.systemPink
        labelTitulo.sizeToFit()
        labelTitulo.autoresizingMask = .flexibleWidth
        labelTitulo.translatesAutoresizingMaskIntoConstraints = true
        labelTitulo.frame = CGRect(x: 50, y: 8, width: contentView.frame.width, height: 10)
        labelTitulo.textAlignment = .left
        self.contentView.addSubview(labelTitulo)
        
        labelAlbum.text = "Album • \(self.track!.album)"
        labelAlbum.font = UIFont.systemFont(ofSize: 10)
        labelAlbum.textColor = UIColor.systemPink
        labelAlbum.autoresizingMask = .flexibleWidth
        labelAlbum.translatesAutoresizingMaskIntoConstraints = true
        labelAlbum.frame = CGRect(x: 50, y: 20, width: contentView.frame.width, height: 10)
        labelAlbum.textAlignment = .left
        self.contentView.addSubview(labelAlbum)
        
        imageViewAlbum.translatesAutoresizingMaskIntoConstraints = true
        imageViewAlbum.frame = CGRect(x: 0, y: 4, width: 35, height: 35)
        imageViewAlbum.backgroundColor = UIColor.white
        imageViewAlbum.image = UIImage(named: "ImageAlbum")
        self.contentView.addSubview(imageViewAlbum)
        
        buttonPlay.clipsToBounds = true
        buttonPlay.backgroundColor = UIColor.black
        buttonPlay.setImage(UIImage(named: "ImagePlay"), for: .normal)
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonPlay)
        NSLayoutConstraint.activate([
            buttonPlay.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            buttonPlay.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            buttonPlay.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            buttonPlay.widthAnchor.constraint(equalTo: buttonPlay.heightAnchor)
        ])
    }
    
}
