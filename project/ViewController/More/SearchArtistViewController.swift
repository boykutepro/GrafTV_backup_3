//
//  SearchArtistViewController.swift
//  project
//
//  Created by thanh on 7/20/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class SearchArtistViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate {
    
      var searchKey = ""
     var items = [Video]()
    
    class func newVC() ->  SearchArtistViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:  SearchArtistViewController.className) as!  SearchArtistViewController
    }
    @IBOutlet weak var tableView: UITableView!
     @IBOutlet var searchBar: UISearchBar!

    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupTBV(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NgheSiTableViewCell.className, bundle: nil), forCellReuseIdentifier: NgheSiTableViewCell.className)
        tableView.tableFooterView = UIView()
       
        
    }
    
    private func setupSearchTextField() {
                 let searchTextField:UITextField = searchBar.textField
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
           getDataFromServer()
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
           self.items.removeAll()
           self.tableView.reloadData()
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        
          setupTBV()
          searchBar.delegate = self
          setupSearchTextField()
        // Do any additional setup after loading the view.
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
    
    func  getDataFromServer(){
           if let text = self.searchBar.text, text.count > 0{
               searchKey = text
            APIService.shared.getSearchVideoArtist(keyword: searchKey) { [weak self] (arrSearch) in
                   if let self = self {
                                     self.items.removeAll()
                                     if let arrSearch = arrSearch {
                                         DispatchQueue.main.async {
                                             self.items.append(contentsOf: arrSearch)
                                             self.tableView.pullToRefreshView?.stopAnimating()
                                             self.tableView.reloadData()
                                         }
                                     }
                                 }
                        }
                }
       }

     func loadMoreDataFromServer(){
          if items.count % PER_PAGE == 0 && searchKey.count > 0{
                   let page = items.count / PER_PAGE
                  APIService.shared.getSearchVideoArtist(keyword: searchKey , page: page) { [weak self] (arrSearch) in
                                 if let self = self , let arrSearch = arrSearch {
                                         DispatchQueue.main.async {
                                             self.items.append(contentsOf: arrSearch)
                                             self.tableView.infiniteScrollingView?.stopAnimating()
                                             self.tableView.reloadData()
                                         }
            
                                 }
                                 
                             }
               }else {
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
