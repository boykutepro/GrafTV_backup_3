//
//  AlbumViewController.swift
//  project
//
//  Created by tranthanh on 4/15/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class AlbumViewController: BaseViewController {
    class func newVC() -> AlbumViewController {
               let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
           return storyBoard.instantiateViewController(withIdentifier: AlbumViewController.className) as! AlbumViewController
         }
  @IBOutlet weak var tableView: UITableView!
    func setupTbv(){
       tableView.dataSource = self
       tableView.delegate = self
       tableView.register(UINib(nibName: ArtistTableViewCell.className, bundle: nil), forCellReuseIdentifier: ArtistTableViewCell.className)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

          setupTbv()
    }

}

extension AlbumViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.className, for: indexPath) as! ArtistTableViewCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

