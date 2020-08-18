//
//  ArtistViewController.swift
//  project
//
//  Created by tranthanh on 4/15/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit


protocol TabArtistControllerProtocol : class {
    func onOpenSongByArtist(artist: Artist)
}

class ArtistViewController: BaseViewController {
//    
    class func newVC() -> ArtistViewController {
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            return storyBoard.instantiateViewController(withIdentifier: ArtistViewController.className) as! ArtistViewController
      }
    
    @IBOutlet weak var tableView: UITableView!
    var songByArtistController: SongByArtistController!
    var listData = [Artist]()
    weak var delegate: TabArtistControllerProtocol?
    func setupTbv(){
       tableView.dataSource = self
       tableView.delegate = self
       tableView.register(UINib(nibName: ArtistTableViewCell.className, bundle: nil), forCellReuseIdentifier: ArtistTableViewCell.className)
        tableView.tableFooterView = UIView()
    }


   
    func setupTBV(){
           tableView.dataSource = self
           tableView.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTbv()
        getData()
    }


    func getData()  {
           self.listData = ARTISTS
           self.tableView.reloadData()
       }

}
extension ArtistViewController : UITableViewDelegate , UITableViewDataSource , ItemClickedListener{
    func onItemClicked(position: Int) {
        let songByArtistController = SongByArtistController.newVC()
        songByArtistController.artist = self.listData[position]
        self.navigationController?.pushViewController(songByArtistController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.className, for: indexPath) as! ArtistTableViewCell
       cell.bind(index: indexPath.row, item: self.listData[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
