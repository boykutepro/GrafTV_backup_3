//
//  MoreNgheSiViewController.swift
//  project
//
//  Created by tranthanh on 4/23/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit




class MoreArtistVC: BaseViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate {

    class func newVC() -> MoreArtistVC {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: MoreArtistVC.className) as! MoreArtistVC
    }
    
   
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Video]()
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupTBV(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NgheSiTableViewCell.className, bundle: nil), forCellReuseIdentifier: NgheSiTableViewCell.className)
        tableView.tableFooterView = UIView()
       
        
    }
    @IBAction func seachButton(_ sender: Any) {
        let vc =    SearchArtistViewController.newVC()
        self.navigationController?.pushViewController(vc, animated: true)
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
        APIService.shared.getVideoViewMore(new_release: 0, chart: 0, artist: 1, category: 0) { [weak self] (items) in
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
    
   
    
    
    
   


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NgheSiTableViewCell.className, for: indexPath) as! NgheSiTableViewCell
        if items.count == 0 {return cell}
        cell.bind(item : items[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = items[indexPath.row]
        item.isArtist = true
        let detailCategory = GenresDetailVC.newVC()
        detailCategory.item = item
        self.navigationController?.pushViewController(detailCategory, animated: true)
    }
    
    
    
}



