//
//  DetailCategoryViewController.swift
//  project
//
//  Created by tranthanh on 4/20/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import Parchment
class GenresDetailVC: BaseViewController {
    
    class func newVC() -> GenresDetailVC {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: GenresDetailVC.className) as! GenresDetailVC
    }
    
    @IBOutlet var imgThumb: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playlistView: UIView!
    @IBOutlet weak var mainSegment: UISegmentedControl!
    let videoVC  = VideoViewController.newVC()
    let playlistVC = PlaylistVC.newVC()
     
    
    var item : Video?
    
    
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var btnFavorite: UIButton!
    @IBAction func btnFavorite(_ sender: Any) {
        favorite()
    }
    
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    

    func favorite()  {
           if let item = item {
            if item.isArtist {
                if !FAVORITED_ARTIST.contains(where: { $0.id == item.id }) {
                    FAVORITED_ARTIST.append(item)
                    btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
                    showToast(message: "Favourited")
                }else{
                    let size = FAVORITED_ARTIST.count
                    for i in 0...size {
                        let song = FAVORITED_ARTIST[i]
                        if song.id == item.id{
                            FAVORITED_ARTIST.remove(at: i)
                            break
                        }
                    }
                    btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
                    showToast(message: "Un Favourited")
                }
            } else {
                if !FAVORITED_GENRES.contains(where: { $0.id == item.id }) {
                    FAVORITED_GENRES.append(item)
                    btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
                    showToast(message: "Favourited")
                }else{
                    let size = FAVORITED_GENRES.count
                    for i in 0...size {
                        let song = FAVORITED_GENRES[i]
                        if song.id == item.id{
                            FAVORITED_GENRES.remove(at: i)
                            break
                        }
                    }
                    btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
                    showToast(message: "Un Favourited")
                }
            }
           }

       }
    
    func checkFavorited(){
           if let item = item {
            if item.isArtist {
                if FAVORITED_ARTIST.contains(where: { $0.id == item.id }) {
                   self.btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
                } else {
                    self.btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
                }
            } else {
                if FAVORITED_GENRES.contains(where: { $0.id == item.id }) {
                        self.btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
                        } else {
                            self.btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
                }
            }
           }
    }
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFavorited()
        setData()
        videoVC.item = item
        playlistVC.item = item
        createPageMenu()
    }
    
    
    
     @IBOutlet weak var containerView: UIView!
        
        func createPageMenu(){
             videoVC.title = "Video"
             playlistVC.title = "Playlist"
            let pagingViewController = PagingViewController(viewControllers: [
               videoVC,playlistVC
            ])
            
            addChild(pagingViewController)
            containerView.addSubview(pagingViewController.view)
            containerView.constrainToEdges(pagingViewController.view)
            pagingViewController.didMove(toParent: self)
            
            // Customize the menu styling.
            pagingViewController.selectedTextColor = .white
            pagingViewController.textColor = .white
            pagingViewController.backgroundColor = .clear
            pagingViewController.menuBackgroundColor = .clear
            pagingViewController.selectedBackgroundColor = .clear
            pagingViewController.indicatorColor = UIColor.white
            pagingViewController.borderColor = .clear
            pagingViewController.indicatorOptions = .visible(
                height: 3,
                zIndex: Int.max,
                spacing: .zero,
                insets: .zero
            )
         }
    
    
    
    func setData() {
        imgView.setImage(url: item?.img_thumb ?? "")
        lblTitle.text = item?.name
        imgThumb.setImage(url: item?.img_thumb ?? "")
    }
    
    
    

}


