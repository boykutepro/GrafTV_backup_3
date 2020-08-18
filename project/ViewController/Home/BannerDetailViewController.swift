//
//  BannerDetailViewController.swift
//  project
//
//  Created by tranthanh on 4/16/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit



class BannerDetailViewController: BaseViewController {
    
    class func newVC() -> BannerDetailViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: BannerDetailViewController.className) as! BannerDetailViewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    var items = [Video]()
    var item : Video?
    
    func favorite(btnFavorite : UIButton)  {
        if let item = item {
            if !FAVORITED_CHART.contains(where: { $0.id == item.id  }) {
                       FAVORITED_CHART.append(item)
                       btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
                       showToast(message: "Favourited")
                      
                  } else {
                      FAVORITED_CHART =  FAVORITED_CHART.filter { $0.id != item.id  }
                      btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
                      showToast(message: "Un Favourited")
                  }
        }

    }
 
    
    func setupTBV(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellVideo.className, bundle: nil) , forCellReuseIdentifier: CellVideo.className)
        tableView.tableFooterView = UIView()
       
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
      
        setupTBV()
        
        getDataFromServer()
                      
        tableView.addPullToRefresh { [weak self] in
                                  if let self = self {
                                      self.getDataFromServer()
                                  }
                                  
                              }
        tableView.addInfiniteScrolling { [weak self] in
                                  if let self = self {
                                      self.loadMoreDataFromServer()
                                  }
                                  
                              }
       
     
    }
    

    
    func getDataFromServer(){
        if let item = item {
            APIService.shared.getListVideo(playlist_id: item.id) {  [weak self] (items) in
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
        if let item = item {
            if items.count % PER_PAGE == 0 {
                               let page = items.count / PER_PAGE
                              APIService.shared.getListVideo(playlist_id: item.id , page: page) { [weak self] (items) in
                                  if let self = self , let items = items {
                                          DispatchQueue.main.async {
                                              self.items.append(contentsOf: items)
                                              self.tableView.infiniteScrollingView?.stopAnimating()
                                              self.tableView.reloadData()
                                          }
                                  }
                              }
                           } else {
                               self.tableView.infiniteScrollingView?.stopAnimating()
                           }
             }
               
    }
    
    
    
  
    
}

extension BannerDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
              return 2
          }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == 0 {
                  return 1
               } else {
                 return items.count
        }
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        switch indexPath.section {
                case 0:
                   let headerCell = tableView.dequeueReusableCell(withIdentifier: MoreImageVideoTableViewCell.className, for: indexPath) as! MoreImageVideoTableViewCell
                   if items.count == 0 {return headerCell}
                   if let item = item {
                      headerCell.bindCell(item: item)
                      headerCell.checkFavorited(item: item)
                   }
                  
                   headerCell.clickBack = { [weak self] in
                       if let self = self {
                           self.navigationController?.popViewController(animated: true)
                       }
                   }
                  
                   
                   headerCell.clickHeart = { [weak self] (button)in
                                                     if let self = self {
                                                        self.favorite(btnFavorite: button)
                                    }
                    }
                   
                   
                    return  headerCell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: CellVideo.className, for: indexPath) as! CellVideo
                    if items.count == 0 {return cell}
                    cell.bind(item: items[indexPath.row],index: indexPath.row)
                    cell.delegate = self
                    return cell
                }
           
           
         
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           if indexPath.section == 0 {
                      return 200
                  } else {
                      return 100
           }
           
       }
   
    
   
    
}




extension BannerDetailViewController : ItemVideoListener {
    func onMenuOption(index: Int) {
         showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
         UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: items[index], playlistitems:  items)
    }
}
