//
//  BackgroundCollectionViewController.swift
//  iChat
//
//  Created by David Kababyan on 01/07/2018.
//  Copyright © 2018 David Kababyan. All rights reserved.
//

import UIKit
import ProgressHUD

class BackgroundCollectionViewController: NavLeftViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    class func newVC() ->  BackgroundCollectionViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:  BackgroundCollectionViewController.className) as!  BackgroundCollectionViewController
    }
    var backgrounds: [UIImage] = []
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var collectionView: UICollectionView!

    var urlString : [String] = []
    
    
    override func isNavBar() -> Bool {
        return true
    }
    
    override func onNavBack() {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setNavTitle(title: "Theme")
        getApi()

    }

    
    
    func getApi() {
         APIService.shared.getSettingTheme { [weak self](item) in
            if let item = item , let self = self  {
                self.urlString = item.theme
               self.collectionView.reloadData()
            }
        }
    }
    



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urlString.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackgroundCollectionViewCell.className, for: indexPath) as! BackgroundCollectionViewCell
        cell.generateCell(image: urlString[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image  = urlString[indexPath.row]
        saveImageBackGround(image)
        NotificationCenter.default.post(name: NSNotification.Name(kBACKGROUBNDIMAGE), object: nil, userInfo: nil)
        ProgressHUD.showSuccess("Set!")
    }
    
    //MARK: IBActions
    
    @objc func resetToDefault() {
        userDefaults.removeObject(forKey: kBACKGROUBNDIMAGE)
        userDefaults.synchronize()
        ProgressHUD.showSuccess("Set!")
    }

}



