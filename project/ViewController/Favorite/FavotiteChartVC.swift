//
//  DanhsachNhacYeuThichViewController.swift
//  project
//
//  Created by tranthanh on 5/3/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class FavotiteChartVC: BaseViewController {

    class func newVC() -> FavotiteChartVC {
           let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
           return storyBoard.instantiateViewController(withIdentifier: FavotiteChartVC.className) as! FavotiteChartVC
       }
    @IBOutlet weak var tableView: UITableView!
//    override func isNavBar() -> Bool {
//           return true
//    }
    
    var items = [Video]()
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DanhSachPhatTableViewCell.className, bundle: nil), forCellReuseIdentifier: DanhSachPhatTableViewCell.className)
        tableView.tableFooterView = UIView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         setTableView()
//         setNavTitle(title: "Favotite Chart")
        view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.items = FAVORITED_CHART
        self.tableView.reloadData()
    }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         var item = items[indexPath.row]
         let detailBanner = BannerDetailViewController.newVC()
         item.isBanner = true
         detailBanner.item = item
        self.navigationController?.pushViewController(detailBanner, animated: true)
     }
     
}

extension FavotiteChartVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DanhSachPhatTableViewCell.className, for: indexPath) as! DanhSachPhatTableViewCell
         cell.bind(item: items[indexPath.row], index : indexPath.row)
         cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 160
       }
       
    
}

extension FavotiteChartVC : ItemVideoListener {
    func onMenuOption(index: Int) {
        showActionListSong(index: index)
    }
    
    private func showActionListSong(index: Int) {
             let actionMenuAlert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
             

             
             let actionUnfavorite = UIAlertAction(title: "Unfavorite", style: .default, handler: {(_) in
                 self.unFavorite(item: self.items[index])
                  
             })
             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in}
             actionMenuAlert.addAction(actionUnfavorite)
             actionMenuAlert.addAction(cancelAction)
             self.checkAlertOnIPad(alertController: actionMenuAlert)
             self.present(actionMenuAlert, animated: true, completion: nil)
         }
    
    func unFavorite(item: Video)  {
        let size =  FAVORITED_CHART.count
        for i in 0...size {
            let song =  FAVORITED_CHART[i]
            if song.id == item.id{
                 FAVORITED_CHART.remove(at: i)
                break
            }
        }
        items =  FAVORITED_CHART
        tableView.reloadData()
        showToast(message: "Un Favourited")
        
    }
    
    func onItemVideoClicked(index: Int) {
//        QueuItemYoutube.shared().addNewVideo(items: items)
//        QueuItemYoutube.shared().currentPosition = index
//        NotificationCenter.default.post(name: NSNotification.Name(NotificationID.PLAY), object:nil, userInfo: ["data":""])
    }
    
   
}





