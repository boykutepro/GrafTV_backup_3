//
//  MoreCategoryViewController.swift
//  project
//
//  Created by tranthanh on 4/21/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class MoreGenresVC: NavLeftViewController {
    
    class func newVC() -> MoreGenresVC {
          let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
          return storyBoard.instantiateViewController(withIdentifier: MoreGenresVC.className) as! MoreGenresVC
    }
    
    override func isNavBar() -> Bool {
        return true
    }

    @IBOutlet weak var collectionView: UICollectionView!
  
    var items = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: "Genres")
        setUpCategory()
        getDataFromServer()
               
               collectionView.addPullToRefresh { [weak self] in
                           if let self = self {
                               self.getDataFromServer()
                           }
                           
                       }
                 collectionView.addInfiniteScrolling { [weak self] in
                           if let self = self {
                               self.loadMoreDataFromServer()
                           }
                           
                       }
                 
    }
    
    
    
    func setUpCategory(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MoreCategoryCVC.className, bundle: nil), forCellWithReuseIdentifier: MoreCategoryCVC.className)
        
    }
    
    
     func getDataFromServer(){
               APIService.shared.getVideoViewMore(new_release: 0, chart: 0, artist: 0, category: 1) { [weak self] (items) in
                   if let self = self {
                       self.items.removeAll()
                       if let items = items {
                           DispatchQueue.main.async {
                               self.items.append(contentsOf: items)
                               self.collectionView.pullToRefreshView?.stopAnimating()
                               self.collectionView.reloadData()
                           }
                       }
                   }
               }
              
           }
           
           func loadMoreDataFromServer(){
                    if items.count % PER_PAGE == 0 {
                        let page = items.count / PER_PAGE
                       APIService.shared.getVideoViewMore(new_release: 0, chart: 0, artist: 0, category: 1, page: page) { [weak self] (items) in
                           if let self = self , let items = items {
                                   DispatchQueue.main.async {
                                       self.items.append(contentsOf: items)
                                       self.collectionView.infiniteScrollingView?.stopAnimating()
                                       self.collectionView.reloadData()
                                   }
                           }
                       }
                    } else {
                        self.collectionView.infiniteScrollingView?.stopAnimating()
                    }
                }

    }
    


extension MoreGenresVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  MoreCategoryCVC.className, for: indexPath) as! MoreCategoryCVC
        if items.count == 0 {return cell}
        cell.bind(item : items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var item = items[indexPath.row]
        item.isArtist = false
        let detaiCategory = GenresDetailVC.newVC()
        detaiCategory.item = item
        self.navigationController?.pushViewController(detaiCategory, animated: true)
    }
    
    
    
    
}

extension MoreGenresVC : UICollectionViewDelegateFlowLayout {
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 5
       }

      //fix line spacing on horizontal line between cells
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 5
       }

       //set size of collection view cells
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let withItem = (screenWidth - 30) / 3
        switch indexPath.row {
        case 0:
             let cvWidth = screenWidth - 10
            return  CGSize(width: cvWidth, height: withItem)
        case 1:
            let cvWidth = screenWidth - withItem - 20
            return  CGSize(width: cvWidth, height: withItem)
        default:
            let cvWidth = withItem
            return  CGSize(width: cvWidth, height: cvWidth)
        }

       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 5, bottom: 0, right: 5)
    }

}
