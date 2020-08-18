//
//  PlaylistDialogViewController.swift
//  project
//
//  Created by Trang Pham on 1/28/19.
//  Copyright © 2019 SUUSOFT. All rights reserved.
//

import UIKit
protocol ItemClickedListener {
    func onItemClicked(position : Int)
}

class PlaylistDialogViewController: BaseViewController, ItemClickedListener {
    

    @IBOutlet weak var playlistCollections: UICollectionView!
    
    @IBOutlet weak var btnCreate: UIButton!

    
    var listPlaylists: [PlaylistVideo] = [PlaylistVideo]()
    
    var song: Video!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        Utilities.createCornerRadius(for: btnCreate, radius: btnCreate.frame.height/2)
        btnCreate.tintColor = UIColor(Colors.primaryColor)
        listPlaylists = DataStoreManager.shared().getListPlaylist() ?? []
    }
    
  
    @IBAction func onClickCreatePlaylist(_ sender: Any) {
        showCreatePlaylist()
    }
    private func setUpCollectionView(){
        playlistCollections.register(UINib(nibName: ItemPlaylistCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ItemPlaylistCollectionViewCell.className)
        playlistCollections.dataSource = self
        playlistCollections.delegate = self
        
    }
    var alert: UIAlertController!
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        let text = sender.text!
        let actionOk = alert.actions[0]
        if(text.isEmpty == true || text.isNumber == true){
            actionOk.isEnabled = false
        }else{
            actionOk.isEnabled = true
        }
    }
    
    private func showCreatePlaylist(){
        alert = UIAlertController(title: "Danh Sách Mới", message: "", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Tạo Nên", style: .default, handler: {(_) in
            let title = self.alert.textFields?[0].text
            let playlist = PlaylistVideo(id: title!, title: title!,image: "", videos: [])
            playlist.image = self.song.img_thumb
            playlist.videos.append(self.song)
            self.addPlaylist(playlist)
            if(self.listPlaylists.isEmpty == false){
                DataStoreManager.shared().saveListPlaylist(self.listPlaylists)
                self.showToast(message: "Added to playlist")
                self.dismiss(animated: true, completion: nil)
            }
        })
        let actionCancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: {(_) in
            self.alert.dismiss(animated: true, completion: nil)
        })
        alert.addTextField { (textField) in
            
            textField.placeholder = "Tên danh sách mới".localized()
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
        }
        actionOk.isEnabled = false
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addPlaylist(_ playlist: PlaylistVideo){
        self.listPlaylists.append(playlist)
        playlistCollections.reloadData()
    }
  
    func onItemClicked(position: Int) {
        if self.listPlaylists[position].videos.count == 0 {
            self.listPlaylists[position].image = song.img_thumb
        }else{ // check the song was existed 
            let listTemp = self.listPlaylists[position].videos
            for item in listTemp{
                if item.id == song.id{
                    self.showToast(message: "This song already exists in playlist")
                    return
                }
            }
        }
        self.listPlaylists[position].videos.append(self.song)
        DataStoreManager.shared().saveListPlaylist(self.listPlaylists)
        self.showToast(message: "Added to playlist")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


extension PlaylistDialogViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPlaylists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.playlistCollections.dequeueReusableCell(withReuseIdentifier: ItemPlaylistCollectionViewCell.className, for: indexPath) as! ItemPlaylistCollectionViewCell
        cell.bindDataDialog(listPlaylists[indexPath.row],index: indexPath.row)
        cell.delegate = self
        return cell
        
    }
    
    
}

extension PlaylistDialogViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.playlistCollections.frame.width
        let height = width/5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}


extension String {
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
    }
}
