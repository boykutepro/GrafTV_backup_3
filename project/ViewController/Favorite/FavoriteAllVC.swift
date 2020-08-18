//
//  PlaylistsViewController.swift
//  project
//
//  Created by tranthanh on 4/15/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import MediaPlayer


class FavoriteAllVC: UIViewController , IOnPlistDetailDelegate {
    func onPlaylistDetailRefresh() {
        DataStoreManager.shared().saveListPlaylist(listPlaylists)
        listPlaylists = DataStoreManager.shared().getListPlaylist() ?? []
        playlistCollections.reloadData()
    }
    
    class func newVC() -> FavoriteAllVC {
          let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyBoard.instantiateViewController(withIdentifier: FavoriteAllVC.className) as! FavoriteAllVC
    }
    
    @IBOutlet weak var playlistCollections: UICollectionView!
    
    @IBAction func btnChart(_ sender: Any) {
        let favoriteChart = FavotiteChartVC.newVC()
        self.navigationController?.pushViewController(favoriteChart, animated: true)
    }
    
    
    @IBAction func btnGenres(_ sender: Any) {
        let favoriteGenres =  FavoriteGenresViewController.newVC()
               self.navigationController?.pushViewController(favoriteGenres, animated: true)
    }
    
    @IBAction func btnArtist(_ sender: Any) {
        let artistPlaylist = FavoriteArtistViewController.newVC()
        self.navigationController?.pushViewController(artistPlaylist, animated: true)
    }
    
    @IBAction func btnNhacOfflineYeuThich(_ sender: Any) {
        let nhacOfflineYeuThich = NhacOfflineViewController.newVC()
        self.navigationController?.pushViewController(nhacOfflineYeuThich, animated: true)
        
    }
    
    @IBAction func btnVideoYeuThich(_ sender: Any) {
        let videoYeuThich = FavoriteVideoVC.newVC()
        videoYeuThich.listData = FAVORITED_VIDEO
        self.navigationController?.pushViewController(videoYeuThich, animated: true)
    }
    
    var listPlaylists = [PlaylistVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPlaylists = DataStoreManager.shared().getListPlaylist() ?? []
         setUpCollectionView()
        registerNotificaton()
      
    }
    
 
  

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func setUpCollectionView(){
       
        playlistCollections.register(UINib(nibName: ItemPlaylistCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ItemPlaylistCollectionViewCell.className)
        playlistCollections.dataSource = self
        playlistCollections.delegate = self
        
    }
    func onPlaylistDeleted() {
        listPlaylists = DataStoreManager.shared().getListPlaylist() ?? []
        playlistCollections.reloadData()
    }
    
    func registerNotificaton()  {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatePlaylist(notification:)), name: NSNotification.Name(NotificationID.UPDATE_PLAYLIST), object: nil)
    }
    
  @objc func updatePlaylist(notification: Notification)  {
     self.onPlaylistDeleted()
  }
  
  
}

extension FavoriteAllVC: UICollectionViewDataSource, UICollectionViewDelegate, ItemClickedListener{
    
    func onItemClicked(position: Int) {
        let playlistDetailController = PlaylistDetailController.newVC()
        playlistDetailController.item = self.listPlaylists[position]
        playlistDetailController.delegate = self
        self.navigationController?.pushViewController(playlistDetailController, animated: true)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPlaylists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.playlistCollections.dequeueReusableCell(withReuseIdentifier: ItemPlaylistCollectionViewCell.className, for: indexPath) as! ItemPlaylistCollectionViewCell
        cell.bindData(listPlaylists[indexPath.row],index: indexPath.row)
        cell.delegate = self
        return cell
        
    }
    
}


extension FavoriteAllVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = screenWidth
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


