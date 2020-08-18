//
//  FavoriteGenresViewController.swift
//  project
//
//  Created by thanh on 7/20/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class FavoriteGenresViewController: NavLeftViewController {
    class func newVC() -> FavoriteGenresViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:  FavoriteGenresViewController.className) as!  FavoriteGenresViewController
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func isNavBar() -> Bool {
              return true
    }
       
    func setUpCategory(){
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.register(UINib(nibName: MoreCategoryCVC.className, bundle: nil), forCellWithReuseIdentifier: MoreCategoryCVC.className)
         
      }
      
    
    var items = [Video]()
    
       var isFirstLoad = true
       override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
        if isFirstLoad {
            let theWidth = (screenWidth - (30))/3
            if let collectionView = collectionView.collectionViewLayout  as? UICollectionViewFlowLayout {
                       
                            collectionView.itemSize.width = theWidth
                collectionView.itemSize.height = theWidth
                collectionView.invalidateLayout()
                            
                         }
        }
        
        
          self.items =  FAVORITED_GENRES
           self.collectionView.reloadData()
      }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle(title: "Favorite Genres")
        setUpCategory()
       
    }
    

}


extension FavoriteGenresViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
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
