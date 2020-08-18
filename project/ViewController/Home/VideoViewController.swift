//
//  VideoCategoryViewController.swift
//  project
//
//  Created by tranthanh on 4/20/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import SVPullToRefresh

let PER_PAGE = 10
class VideoViewController: BaseViewController {
    
   class func newVC() -> VideoViewController {
             let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
         return storyBoard.instantiateViewController(withIdentifier: VideoViewController.className) as! VideoViewController
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
                 self.getDataCategoryFromServer()
            }
            
         }
          
      }
    
    func setupTBV(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellVideo.className, bundle: nil), forCellReuseIdentifier: CellVideo.className)
        tableView.tableFooterView = UIView()
        
    }
    
   
    
    func getDataCategoryFromServer(){
             if let item = item {
               APIService.shared.getVideoCategory(category_id: item.id, list: "song") {[weak self] (items) in
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
            APIService.shared.getVideoArtist(artist_id: item.id, list: "song") {[weak self] (items) in
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
                        APIService.shared.getVideoArtist(artist_id: item.id, list: "song" , page: page) {[weak self] (items) in
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
                        APIService.shared.getVideoCategory(category_id: item.id, list: "song" , page: page) {[weak self] (items) in
                            if let self = self , let items = items {
                            
                                                       DispatchQueue.main.async {
                                                           self.items.append(contentsOf: items)
                                                           self.tableView.pullToRefreshView?.stopAnimating()
                                                           self.tableView.reloadData()
                                                       }
                            }
                        }
                    }
              } else {
                   self.tableView.infiniteScrollingView?.stopAnimating()
              }
    }
    
    
}



extension VideoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellVideo.className, for: indexPath) as! CellVideo
        if items.count == 0 {return cell}
        cell.bind(item: items[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
   
    
}

extension VideoViewController : ItemVideoListener {
    func onMenuOption(index: Int) {
        showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
           UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: items[index], playlistitems: items)
    
    }
    
   
}
