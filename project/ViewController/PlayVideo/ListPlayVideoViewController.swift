//
//  ListPlayVideoViewController.swift
//  project
//
//  Created by tranthanh on 5/9/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class ListPlayVideoViewController: UIViewController {
    
    class func newVC() -> ListPlayVideoViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: ListPlayVideoViewController.className) as! ListPlayVideoViewController
    }
    
    var items = [Video]()
    
    func setupTBV(){
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UINib(nibName: CellVideo.className, bundle: nil), forCellReuseIdentifier: CellVideo.className)
           tableView.tableFooterView = UIView()
       }
       
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupTBV()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        showAnimated()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closePopup(sender:)))
        view.addGestureRecognizer(tap)
    }
    

    func showAnimated(){
        self.tableView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        self.tableView.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseOut, animations: {
            self.tableView.alpha = 1
            self.tableView.transform = .identity
        }, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            removeAnimated()
    }
    
    func removeAnimated(){
        self.tableView.transform =  CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        self.tableView.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
             self.tableView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
             self.tableView.alpha = 0
        }) { (finish) in
            self.view.removeFromSuperview()
        }
    }
    
    @objc func closePopup(sender : UIGestureRecognizer){
        if let viewTapped  = sender.view {
            if viewTapped != tableView {
                 self.view.removeFromSuperview()
            }
        }
    }
    

    

}

extension ListPlayVideoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellVideo.className, for: indexPath) as! CellVideo
        
        cell.bind(item: items[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   
     
    
}

extension ListPlayVideoViewController : ItemVideoListener {
    func onMenuOption(index: Int) {
        showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
        let item = items[index]
        if item.uri.isEqual("") {
            UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: item, playlistitems: items)
        } else {
            SearchSpotifyDataStore.share.getYoutubeIdSporty(keyword: item.name, spotify_track_id: item.id) { (item) in
                         if let item = item  {
                           self.items[index].song_url = item.youtubeId
                           UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: self.items[index], playlistitems: self.items)
                         }
          }
        }
        
        
    }
    
   
}
