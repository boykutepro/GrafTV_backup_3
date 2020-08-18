//
//  ListPlayAudioViewController.swift
//  project
//
//  Created by tranthanh on 5/19/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit


import UIKit

class ListPlayAudioViewController: UIViewController {
    
    class func newVC() -> ListPlayAudioViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: ListPlayAudioViewController.className) as! ListPlayAudioViewController
    }
    
    var items = [SongItem]()
    
    func setupTBV(){
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UINib(nibName: SongTableViewCell.className, bundle: nil), forCellReuseIdentifier:  SongTableViewCell.className)
           tableView.tableFooterView = UIView()
       }
       
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupTBV()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        showAnimated()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closePopup(sender:)))
        view.addGestureRecognizer(tap)
    }
    

    func showAnimated(){
        self.tableView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        self.tableView.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseOut, animations: {
            self.tableView.alpha = 1
            self.tableView.transform = .identity
        }, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            removeAnimated()
    }
    
    func removeAnimated(){
        self.tableView.transform =  CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        self.tableView.alpha = 0
        UIView.animate(withDuration: 0.25, animations: {
             self.tableView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
             self.tableView.alpha = 0
        }) { (finish) in
            self.view.removeFromSuperview()
        }
    }
    
    @objc func closePopup(sender : UIGestureRecognizer){
        if let viewTapped  = sender.view {
            if viewTapped != tableView {
                 self.view.removeFromSuperview()
            }
        }
    }
    

    

}

extension ListPlayAudioViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.className, for: indexPath) as! SongTableViewCell
        cell.bind(index: indexPath.row, item: items[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension  ListPlayAudioViewController : ItemSongCollectionDelegate {
    func onItemDeleted(item: SongItem) {
        
    }
    
    func onShowActionMenu(actionMenu: UIAlertController) {
         present(actionMenu, animated: true, completion: nil)
    }
    
    func onItemClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsMp3(item: items[index], playlistitems: items)
       
    }
    
    func onItemDeleted(index: Int) {
       
    }

}

