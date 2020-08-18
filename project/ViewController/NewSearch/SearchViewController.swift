//
//  SearchViewController.swift
//  project
//
//  Created by tranthanh on 5/14/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


class SearchViewController: BaseViewController , UISearchBarDelegate  {
    
   
    
    class func newVC() -> SearchViewController {
             let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
             return storyBoard.instantiateViewController(withIdentifier: SearchViewController.className) as! SearchViewController
    }

   
    let searchVideo = SearchVideoViewController.newVC()
    let searchPlaylist = SearchPlaylistViewController.newVC()
  
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playlistView: UIView!
    @IBOutlet weak var mainSegment: UISegmentedControl!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchTextField()
        self.searchBar.delegate = self
        self.embed(searchVideo, inView: videoView)
        self.embed(searchPlaylist, inView: playlistView)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
        
        @IBOutlet weak var searchBar: UISearchBar!
        
        
        
        private func setupSearchTextField() {
            let searchTextField: UITextField = searchBar.textField
            searchTextField.layer.cornerRadius = 18
            searchTextField.layer.masksToBounds = true
            searchTextField.textAlignment = NSTextAlignment.left
            searchTextField.leftView = nil
            searchTextField.placeholder = "Enter key search..."
            searchTextField.rightViewMode = .always
            searchTextField.backgroundColor = .white
            searchTextField.textColor = .black
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            print("searchText \(searchText)")
            
        }
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.showsCancelButton = true
            return true
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            self.searchBar.endEditing(true)
            searchBar.resignFirstResponder()
        }
        
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print("searchText \(String(describing: searchBar.text))")
            searchBar.resignFirstResponder()
             if let keyword = searchBar.text {
                              self.searchVideo.keyword = keyword
                              self.searchVideo.getSearchSpoty()
                              self.searchPlaylist.keyword = keyword
                              self.searchPlaylist.getSearchSpoty()
                   }
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
             self.searchVideo.items = []
                   self.searchVideo.tableView.reloadData()
                   self.searchPlaylist.items = []
                   self.searchPlaylist.tableView.reloadData()
            
            
        }
        
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func settingPressed(_ sender: UIButton) {
        let settingVC = LeftViewController.newVC()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    

    @IBAction func changeSegmentValue(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            videoView.alpha = 1
            playlistView.alpha = 0
        default:
            playlistView.alpha = 1
            videoView.alpha = 0
        }
    }

    
    
}



extension UIViewController {
    func embed(_ viewController:UIViewController, inView view:UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
