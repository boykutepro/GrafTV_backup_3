//
//  KaraokeViewController.swift
//  project
//
//  Created by thanh on 7/18/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import ProgressHUD

class KaraokeViewController: BaseViewController  , UISearchBarDelegate {
    
    class func newVC() ->  KaraokeViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:  KaraokeViewController.className) as!  KaraokeViewController
    }
    var items = [Video]()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var iconSearch: UIImageView!
    
    var searchKey = ""
    
    private func setupSearchTextField() {
        let searchTextField: UITextField = searchBar.textField
        searchTextField.layer.cornerRadius = 18
        searchTextField.layer.masksToBounds = true
        searchTextField.textAlignment = NSTextAlignment.left
        searchTextField.leftView = nil
        searchTextField.placeholder = "Search by songs"
        searchTextField.rightViewMode = .always
        searchTextField.backgroundColor = .clear
        searchTextField.textColor = .white
        searchTextField.layer.borderColor = UIColor.white.cgColor
        searchTextField.layer.borderWidth = 1
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        iconSearch.isHidden = true
        
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        searchBar.resignFirstResponder()
        iconSearch.isHidden = true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(String(describing: searchBar.text))")
        searchBar.resignFirstResponder()
        getSearchKaraoke()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        
        searchBar.resignFirstResponder()
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
        iconSearch.isHidden = false
        self.items.removeAll()
        self.tableView.reloadData()
        
        
    }
    
    func setupTBV(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: CellVideo.className, bundle: nil), forCellReuseIdentifier: CellVideo.className)
        tableView.tableFooterView = UIView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchTextField()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        setupTBV()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBGMusic()
    }
    
    @objc func setBGMusic() {
        if let imageUrl = getImageBackGround() {
            backgroundImage.setImage(url: imageUrl)
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        } else {
            backgroundImage.image = UIImage(named: "bg9")
        }
        
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
    
    
    func getSearchKaraoke(){
        if let text = self.searchBar.text {
            ProgressHUD.show()
            SearchSpotifyDataStore.share.getAccesstoken { (accesstoken) in
                if let accesstoken = accesstoken {
                    SearchKaraokeDataStore.share.searchKaraokeApi(key: accesstoken.key, q: text, part: "snippet", maxResults: "50", responses: { (items) in
                        if let items = items {
                            if  items.count == 0 {
                                self.getSearchKaraoke()
                            } else {
                                self.items = items
                                self.tableView.reloadData()
                                ProgressHUD.dismiss()
                                
                            }
                            
                        }
                        
                    })
                }
            }
        }
        
    }
    
}
extension KaraokeViewController : UITableViewDataSource, UITableViewDelegate {
    
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


extension KaraokeViewController : ItemVideoListener {
    func onMenuOption(index: Int) {
        showMenuActionSong(item: self.items[index])
    }
    
    func onItemVideoClicked(index: Int) {
        UIApplication.mainVC()?.maximizePlayerDetailsVideo(item: self.items[index], playlistitems: self.items)
    }
    
}
extension UISearchBar {
    
    var textField : UITextField {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            return value(forKey: "_searchField") as! UITextField
        }
    }
}
//extension UISearchBar {
//
// var textField : UITextField{
//    return self.value(forKey: "_searchField") as! UITextField
// }
//}
