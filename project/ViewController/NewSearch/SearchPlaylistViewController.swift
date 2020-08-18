//
//  SearchPlaylistViewController.swift
//  project
//
//  Created by tranthanh on 5/14/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class SearchPlaylistViewController: BaseViewController {
    
    class func newVC() -> SearchPlaylistViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: SearchPlaylistViewController.className) as! SearchPlaylistViewController
    }
    
    @IBOutlet weak var tableView: UITableView!
    var keyword : String?
    
    func setupTBV(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DanhSachPhatTableViewCell.className, bundle: nil) , forCellReuseIdentifier: DanhSachPhatTableViewCell.className)
        tableView.tableFooterView = UIView()
    }
    
    
    var items = [Video]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTBV()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
          getSearchSpoty()
    }
    
    func getSearchSpoty(){
           SearchSpotifyDataStore.share.getAccesstoken { (accesstoken) in
               if let accesstoken = accesstoken , let keyword = self.keyword  {
                   SearchSpotifyDataStore.share.getStatusTrans(q: keyword, type: "album", maker: "US", accesstoken: accesstoken.accesstoken) { (items) in
                       if let items = items {
                           self.items = items
                           self.tableView.reloadData()
                       }
                      
                   }
               }
           }
       }
    
}

extension SearchPlaylistViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DanhSachPhatTableViewCell.className, for: indexPath) as! DanhSachPhatTableViewCell
        if items.count == 0 {return cell}
        cell.bind(item: items[indexPath.row] , index : indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = items[indexPath.row]
        item.isBanner = true
        let detailBanner = BannerDetailViewController.newVC()
        detailBanner.item = item
        self.navigationController?.pushViewController(detailBanner, animated: true)
    }

}


extension SearchPlaylistViewController : ItemVideoListener {
    func onMenuOption(index: Int) {
        showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
//                QueuItemYoutube.shared().addNewVideo(items: items)
//                QueuItemYoutube.shared().currentPosition = index
//                NotificationCenter.default.post(name: NSNotification.Name(NotificationID.PLAY), object:nil, userInfo: ["data":""])
    }
    
    
}





