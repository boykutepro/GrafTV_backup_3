//
//  BaseViewController.swift
//
//
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
import ProgressHUD
import SDWebImage
import Localize_Swift



class BaseViewController: UIViewController ,  DownloadFinishedDelegate {
    
   
    func downloadSuccess() {
        showToastWindown(message: "Can not download this file")
    }
    
    func downloadError() {
        showToastWindown(message: "Downloaded")
    }
    
    
    //MARK: - Properties
      
       
       
 let availableLanguages = Localize.availableLanguages()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
      let visualEffectView = UIVisualEffectView(effect: nil)

    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
//          self.setText()
        
          setBG()
//        self.view.backgroundColor = .clear

    }
    
    
       // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
          override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
//            NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(setBG), name: NSNotification.Name(kBACKGROUBNDIMAGE), object: nil)
          }
          
    
    @objc func setBG() {
        if let imageUrl = getImageBackGround() {
        backgroundImage.setImage(url: imageUrl)
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        } else {
           backgroundImage.image = UIImage(named: "bg9")
        }
        
        self.view.insertSubview(backgroundImage, at: 0)
      
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
          override func viewWillDisappear(_ animated: Bool) {
              super.viewWillDisappear(animated)
              NotificationCenter.default.removeObserver(self)
       }
       
    
//    func setStatusBarColor()  {
//        if #available(iOS 13.0, *) {
//            let app = UIApplication.shared
//            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
//            let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
//            statusbarView.backgroundColor =  .clear
//            view.addSubview(statusbarView)
//        } else {
//            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
//            statusBar?.backgroundColor = .clear
//        }
//    }
    
   
    
//    @objc func setText(){
//
//    }
    
    
//    func showHideProgress(isShow: Bool)  {
//        if isShow {
//            ProgressHUD.show()
//        }else{
//           
//            ProgressHUD.dismiss()
//        }
//    }
//    

    func dismiss() {
        self.dismiss(animated: true, completion: nil )
    }
    
    func presentActionSheet(_ vc: VisualActivityViewController, from view: UIView) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            vc.popoverPresentationController?.sourceView = view
            vc.popoverPresentationController?.sourceRect = view.bounds
            vc.popoverPresentationController?.permittedArrowDirections = [.right, .left]
        }
        present(vc, animated: true, completion: nil)
    }
    
    @objc func onChangeLanguage()  {
        // TODO: overide and update your UI
    }
    
    @objc func onChangeTheme()  {
        // TODO : overide and update theme
    }
    
    

    
    
    func actionDownload(item: Song)  {
          self.showToastWindown(message: "Downloading...")
          DownloadManager.share().setDelegate(delegate: self).downloadUrl(item: item)
      }
    
    
    
    
    
    
 
    
}


extension UIViewController {
    func shareButtonClicked(item: Video) {
           let textToShare = item.name
           if let myWebsite = NSURL(string: ABOUT_URL) {
               let objectsToShare = [textToShare!, myWebsite] as [Any]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
               
               //New Excluded Activities Code
               activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
               activityVC.popoverPresentationController?.sourceView = self.view
               self.present(activityVC, animated: true, completion: nil)
           }
       }
       
       func shareButtonClicked(url : String) {
          
           if let myWebsite = NSURL(string: ABOUT_URL) {
               let objectsToShare = [url, myWebsite] as [Any]
               let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
               
               //New Excluded Activities Code
               activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
               activityVC.popoverPresentationController?.sourceView = self.view
               self.present(activityVC, animated: true, completion: nil)
           }
       }
    
    
    
      func setFavorite(item: Video)  {
          if !FAVORITED_VIDEO.contains(where: { $0.id == item.id }) {
              FAVORITED_VIDEO.append(item)
              showToast(message: "Favourited")
          }else{
              showToast(message: "Favourited")
          }
      }
      
      
      func setFavoriteSong(item: Video)  {
             if !FAVORITED_VIDEO.contains(where: { $0.id == item.id }) {
                 FAVORITED_VIDEO.append(item)
                 showToast(message: "Favourited")
             }else{
                 showToast(message: "Favourited")
             }
         }
    
     
      func showActionVideoPlaylist(item: Video, callback: @escaping ()->Void)  {
                let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
                
                let oneAction = UIAlertAction(title: "Favourite", style: .default) { (_) in
                    self.setFavorite(item: item)
                }
      
                let threeAction = UIAlertAction(title: "Remove from playlist", style: .default) { (_) in
                    callback()
                  
                }
                let sharelAction = UIAlertAction(title: "Share", style: .default) { (_) in
                    self.shareButtonClicked(item: item)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                    
                }
                
                alertController.addAction(oneAction)
                alertController.addAction(threeAction)
                alertController.addAction(sharelAction)
                alertController.addAction(cancelAction)
               self.checkAlertOnIPad(alertController: alertController)
                self.present(alertController, animated: true)
            }
      
      func showMenuActionSong(item: Video)  {
                  let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
                  let oneAction = UIAlertAction(title: "Favourite", style: .default) { (_) in
                      self.setFavorite(item: item)
                  }
                  
                  let threeAction = UIAlertAction(title: "Thêm vào Danh Sách Phát", style: .default) { (_) in
                     self.showPlaylistOff(item: item)
                  }
                  let sharelAction = UIAlertAction(title: "Share", style: .default) { (_) in
                      self.shareButtonClicked(item: item)
                  }
                  let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                      
                  }
      

                  alertController.addAction(oneAction)
                  alertController.addAction(threeAction)
                  alertController.addAction(sharelAction)
                  alertController.addAction(cancelAction)
                  
                  
                  self.checkAlertOnIPad(alertController: alertController)
                  self.present(alertController, animated: true)

              }
      
      func showPlaylistOff(item: Video)  {
          let playlistDialogViewController = PlaylistDialogViewController(nibName: PlaylistDialogViewController.className, bundle: nil)
            playlistDialogViewController.song = item
            playlistDialogViewController.modalPresentationStyle = .overCurrentContext
            self.present( playlistDialogViewController, animated: true, completion: nil)
      }
      
      func checkAlertOnIPad(alertController : UIAlertController)  {
             if let popoverPresentationController = alertController.popoverPresentationController{
                 popoverPresentationController.sourceView = self.view
                 
                 let bound = CGRect(x: self.view.bounds.size.width/2.0, y: self.view.bounds.size.height/2.0, width: 0, height: 0)
                 popoverPresentationController.sourceRect = bound
             }
         }
      
    
      
      
     
         
         
       
}

