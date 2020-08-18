//
//  MoreNewVideoViewController.swift
//  project
//
//  Created by tranthanh on 5/3/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class MoreNewVideoViewController: BaseViewController{
    
     class func newVC() -> MoreNewVideoViewController {
         let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
         return storyBoard.instantiateViewController(withIdentifier: MoreNewVideoViewController.className) as! MoreNewVideoViewController
     }
     

    @IBOutlet weak var tableView: UITableView!
    
    var items = [Video]()
   
    
    
   
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
           APIService.shared.getVideoViewMore(new_release: 1, chart: 0, artist: 0, category: 0) { [weak self] (items) in
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
       
       func loadMoreDataFromServer(){
                if items.count % PER_PAGE == 0 {
                    let page = items.count / PER_PAGE
                   APIService.shared.getVideoViewMore(new_release: 1, chart: 0, artist: 0, category: 0 , page: page) { [weak self] (items) in
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


extension MoreNewVideoViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == 0 {
                  return 1
               } else {
                 return items.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     switch indexPath.section {
             case 0:
                let headerCell = tableView.dequeueReusableCell(withIdentifier: MoreImageVideoTableViewCell.className, for: indexPath) as! MoreImageVideoTableViewCell
                headerCell.clickBack = { [weak self] in
                                   if let self = self {
                                       self.navigationController?.popViewController(animated: true)
                                   }
                               }
                if items.count == 0 {return headerCell}
                let item = self.items[0]
                headerCell.bindCell(item: item)
               
               
               
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




extension MoreNewVideoViewController : ItemVideoListener {
    func onMenuOption(index: Int) {
         showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
           UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: items[index], playlistitems: items)
    }
}
