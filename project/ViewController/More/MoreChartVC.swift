//
//  BieuDoViewController.swift
//  project
//
//  Created by tranthanh on 4/28/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class MoreChartVC: NavLeftViewController {
    class func newVC() -> MoreChartVC {
           let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
           return storyBoard.instantiateViewController(withIdentifier: MoreChartVC.className) as! MoreChartVC
    }
    
    var items = [Video]()
       
    override func isNavBar() -> Bool {
        return true
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: "Chart")
        setupTableView()
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
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellBieuDoTbv.className, bundle: nil), forCellReuseIdentifier: CellBieuDoTbv.className)
        tableView.tableFooterView = UIView()
        
    }
  
    
   

    func getDataFromServer(){
        APIService.shared.getVideoViewMore(new_release: 0, chart: 1, artist: 0, category: 0) { [weak self] (items) in
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
                APIService.shared.getVideoViewMore(new_release: 0, chart: 1, artist: 0, category: 0 , page: page) { [weak self] (items) in
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
extension MoreChartVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellBieuDoTbv.className, for: indexPath) as! CellBieuDoTbv
        if items.count == 0 {return cell}
        cell.bind(item: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = items[indexPath.row]
        let detailBanner = BannerDetailViewController.newVC()
        item.isBanner = true
        detailBanner.item = item
        self.navigationController?.pushViewController(detailBanner, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
