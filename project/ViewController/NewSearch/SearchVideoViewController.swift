//
//  SearchVideoViewController.swift
//  project
//
//  Created by tranthanh on 5/14/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import Alamofire

class SearchVideoViewController:  BaseViewController {
    
    class func newVC() -> SearchVideoViewController {
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                return storyBoard.instantiateViewController(withIdentifier: SearchVideoViewController.className) as! SearchVideoViewController
    }
    
  
    var items = [Video]()
    var keyword : String?
    

    
    

    @IBOutlet weak var tableView: UITableView!
    
    func setupTBV(){
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UINib(nibName: CellVideo.className, bundle: nil), forCellReuseIdentifier: CellVideo.className)
           tableView.tableFooterView = UIView()
       }
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
                SearchSpotifyDataStore.share.getStatusTrans(q: keyword, type: "track", maker: "US", accesstoken: accesstoken.accesstoken) { (items) in
                    if let items = items {
                        self.items = items
                        self.tableView.reloadData()
                    }
                   
                }
            }
        }
    }
   


}


extension SearchVideoViewController : UITableViewDataSource, UITableViewDelegate {
    
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
        return 200
    }
}

extension SearchVideoViewController : ItemVideoListener {
    func onMenuOption(index: Int) {
        showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
        
        UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: self.items[index], playlistitems: self.items)
    }
}




extension String {
    
    var toDouble: Double {
        return Double(self) ?? 0.0
    }
    
    var toFloat: Float  {
        return Float(self) ?? 0.0
    }
    
    
    var toInt: Int  {
        return Int(self) ?? 0
    }
    
}
