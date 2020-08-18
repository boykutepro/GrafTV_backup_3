//
//  DanhSachPhatYeuThichViewController.swift
//  project
//
//  Created by tranthanh on 5/3/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class FavoriteArtistViewController: NavLeftViewController {
    class func newVC() -> FavoriteArtistViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: FavoriteArtistViewController.className) as! FavoriteArtistViewController
    }
    
    var items = [Video]()
    
    @IBOutlet weak var tableView: UITableView!
    override func isNavBar() -> Bool {
        return true
    }
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellKenhYeuThich.className, bundle: nil), forCellReuseIdentifier: CellKenhYeuThich.className)
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: "Favorite Artist")
        setTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.items = FAVORITED_ARTIST
        self.tableView.reloadData()
    }
}

extension FavoriteArtistViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellKenhYeuThich.className, for: indexPath) as! CellKenhYeuThich
        cell.bind(item: FAVORITED_ARTIST[indexPath.row])
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let theLoaiChitiet = GenresDetailVC.newVC()
        theLoaiChitiet.item = item
        self.navigationController?.pushViewController(theLoaiChitiet, animated: true)
    }
       
    
}

