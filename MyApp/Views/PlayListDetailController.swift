//
//  PlayListDetailController.swift
//  MyApp
//
//  Created by Facundo Lucero on 29/11/2021.
//

import UIKit

class PlayListDetailController: UIViewController, TracksPickerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    ////var playList : [Track] = []
    ////var tracksArray = [Track]()
    
    var playListNameTextField = UITextField()
    var playListTrackContent: UITableView = UITableView()
    var addSongBtn = UIButton()
    var viewModel: PlayListDetailViewModel = PlayListDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(playListNameTextField)
        self.view.backgroundColor = .black
        
        playListNameTextField.placeholder = "Playlist..."
        playListNameTextField.backgroundColor = UIColor.systemPink.withAlphaComponent(0.9)
        playListNameTextField.textColor = .white
        playListNameTextField.translatesAutoresizingMaskIntoConstraints = false
        playListNameTextField.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        playListNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        playListNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        playListNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(addSongBtn)
        addSongBtn.setImage(UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill"), for: .normal)
        addSongBtn.translatesAutoresizingMaskIntoConstraints=false
        //addSongBtn.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 20).isActive = true
        addSongBtn.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        addSongBtn.leadingAnchor.constraint(equalTo: playListNameTextField.trailingAnchor, constant: 10).isActive = true
        addSongBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addSongBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addSongBtn.addTarget(self, action:#selector(showView), for: .touchUpInside)
        addSongBtn.backgroundColor = UIColor.black
        
        self.view.addSubview(playListTrackContent)
        playListTrackContent.translatesAutoresizingMaskIntoConstraints=false
        playListTrackContent.topAnchor.constraint(equalTo:playListNameTextField.bottomAnchor, constant: 20).isActive = true
        playListTrackContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        playListTrackContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        playListTrackContent.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        playListTrackContent.backgroundColor = .lightGray.withAlphaComponent(0.4)
        playListTrackContent.separatorColor = .systemPink
        playListTrackContent.separatorStyle = .singleLine
        playListTrackContent.register(UITableViewCell.self, forCellReuseIdentifier: "track")
        playListTrackContent.dataSource = self
        playListTrackContent.delegate = self
    }

    @objc func showView() {
        let trv = TracksPickerView (frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
        trv.delegate = self
        self.view.addSubview(trv)
    }

    // MARK: - TableView Datasource & Delegate
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         //tracksArray.count
         viewModel.countOfLines()
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
         //let track = tracksArray[indexPath.row]
         let track = viewModel.trackArrayIndex(indexPath.row)
         cell.textLabel?.text = track.title
         return cell
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playlistSongs.forEach{ cancion in
            if !viewModel.doesntContentElement(cancion){
                self.addTrack(track: cancion)
            }
        }
    }
    
    func addTrack(track: Track) {
        //playList.append(track)
        //tracksArray = playList
        viewModel.addTrack(track)
        playListTrackContent.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
