//
//  ListAlbumViewController.swift
//  project
//
//  Created by tranthanh on 4/20/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class PlaylistVC: BaseViewController {
    
    class func newVC() -> PlaylistVC {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: PlaylistVC.className) as! PlaylistVC
    }
    

    @IBOutlet weak var tableView: UITableView!
    var item : Video?
    var items = [Video]()
  
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTBV()
       
        tableView.addPullToRefresh { [weak self] in
               if let self = self {
                   if let item = self.item {
                   if item.isArtist {
                       self.getDataFromServer()
                           } else {
                       self.getDataCategoryFromServer()
                   }
               }
           }
           }
           tableView.addInfiniteScrolling { [weak self] in
                        if let self = self {
                                  if let item = self.item {
                                  if item.isArtist {
                                      self.loadMoreDataFromServer()
                                          } else {
                                      self.loadMoreCategoryDataFromServer()
                                  }
                              }
                          }
           }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let item = item {
            if item.isArtist {
                    getDataFromServer()
                  } else {
                     getDataCategoryFromServer()
            }
        }
       
    }
    func setupTBV(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DanhSachPhatTableViewCell.className, bundle: nil) , forCellReuseIdentifier: DanhSachPhatTableViewCell.className)
        tableView.tableFooterView = UIView()
    
    }
    
    
   
    
    func getDataCategoryFromServer(){
            
             if let item = item {
               APIService.shared.getVideoCategory(category_id: item.id, list: "playlist") {[weak self] (items) in
                   if let self = self {
                       self.items.removeAll()
                       if let items = items {
                                              DispatchQueue.main.async {
                                                  self.items.append(contentsOf: items)
                                                  self.tableView.pullToRefreshView?.stopAnimating()
                                                self.tableView.reloadData()
                                              }
                                          }
                   }
               }
           }
       
       }
    
    func getDataFromServer(){
         
          if let item = item {
            APIService.shared.getVideoArtist(artist_id: item.id, list: "playlist") {[weak self] (items) in
                if let self = self {
                  
                    self.items.removeAll()
                    if let items = items {
                                           DispatchQueue.main.async {
                                               self.items.append(contentsOf: items)
                                               self.tableView.pullToRefreshView?.stopAnimating()
                                            self.tableView.reloadData()
                                           }
                                       }
                }
            }
        }
    
    }
    
    
    
    func loadMoreDataFromServer(){
              if items.count % PER_PAGE == 0 {
                 let page = items.count / PER_PAGE
                if let item = item {
                        APIService.shared.getVideoArtist(artist_id: item.id, list: "playlist" , page: page) {[weak self] (items) in
                            if let self = self , let items = items {
                            
                                                       DispatchQueue.main.async {
                                                           self.items.append(contentsOf: items)
                                                           self.tableView.pullToRefreshView?.stopAnimating()
                                                          self.tableView.reloadData()
                                                       }
                            }
                        }
                    }
              }else {
                   self.tableView.infiniteScrollingView?.stopAnimating()
              }
    }
    
    func loadMoreCategoryDataFromServer(){
              if items.count % PER_PAGE == 0 {
                 let page = items.count / PER_PAGE
                if let item = item {
                        APIService.shared.getVideoCategory(category_id: item.id, list: "playlist" , page: page) {[weak self] (items) in
                            if let self = self , let items = items {
                            
                                                       DispatchQueue.main.async {
                                                           self.items.append(contentsOf: items)
                                                           self.tableView.pullToRefreshView?.stopAnimating()
                                                           self.tableView.reloadData()
                                                       }
                            }
                        }
                    }
              }else {
               self.tableView.infiniteScrollingView?.stopAnimating()
              }
    }
    
    
   
    
    
   
   
   
}

extension PlaylistVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DanhSachPhatTableViewCell.className, for: indexPath) as! DanhSachPhatTableViewCell
        cell.bind(item: items[indexPath.row] , index : indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = items[indexPath.row]
        item.isBanner = true
        let detailBanner = BannerDetailViewController.newVC()
        detailBanner.item = item
        self.navigationController?.pushViewController(detailBanner, animated: true)
    }
    
   
}


extension PlaylistVC : ItemVideoListener {
    func onMenuOption(index: Int) {
        showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
//        QueuItemYoutube.shared().addNewVideo(items: items)
//        QueuItemYoutube.shared().currentPosition = index
//        NotificationCenter.default.post(name: NSNotification.Name(NotificationID.PLAY), object:nil, userInfo: ["data":""])
    }
    
   
}




