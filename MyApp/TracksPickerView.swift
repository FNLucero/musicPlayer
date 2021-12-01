//
//  TracksPickerView.swift
//  MyApp
//
//  Created by Facundo Lucero on 29/11/2021.
//

import UIKit

protocol TracksPickerDelegate {
    func addTrack(track: Track)
}

class TracksPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return songList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowStr = songList[row]
        return rowStr.title
    }
    
    var delegate:TracksPickerDelegate?
    let picker: UIPickerView = UIPickerView()
    override func draw(_ rect: CGRect) {
        let dimension = 35
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        addButton.tintColor = .red
        addButton.frame = CGRect(x: 3, y: 3, width: dimension, height: dimension)
        self.addSubview(addButton)
        addButton.addTarget(self, action:#selector(close), for: .touchUpInside)
        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "cross.circle.fill"), for: .normal)
        closeButton.tintColor = .green
        closeButton.frame = CGRect(x:Int(rect.width) - (dimension + 3), y: 3, width: dimension, height: dimension)
        self.addSubview(closeButton)
        closeButton.addTarget(self, action:#selector(add), for: .touchUpInside)
        
        picker.frame = CGRect(x: 0, y: 30, width: rect.width, height: rect.height-30)
        picker.delegate = self
        picker.dataSource = self
        self.addSubview(picker)
    }

    @objc func close () {
        self.removeFromSuperview()
    }
    
    @objc func add () {
        if delegate != nil {
            let index = picker.selectedRow(inComponent: 0)
            let track = songList[index]
            delegate?.addTrack(track: track)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      }

}
