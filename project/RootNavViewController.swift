//
//  RootNavViewController.swift
//  project
//
//  Created by thanh on 7/26/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import MediaPlayer


class RootNavViewController: UINavigationController {
    
    let query: MPMediaQuery = MPMediaQuery.songs()
    let tabBarVC = SUTabBarController.newVC()
//    var slidingUpVC = PlayVideoViewController.newVC()
//    var slidingUpVCAudio = PlayAudioViewController.newVC()
//    let slideUpPanelManagerVideo: TSSlidingUpPanelManager = TSSlidingUpPanelManager.with
//    let slideUpPanelManagerMp3: TSSlidingUpPanelManager_MP3 = TSSlidingUpPanelManager_MP3.with
  
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        setSlidingMP3()
//        setSlidingVideo()
//        
//        
//    }
    
    
    
    @objc func openListVideo(notification: Notification){
        guard let yourPassedObject = notification.object as? [Video] else {return}
        let playlist = ListPlayVideoViewController.newVC()
        playlist.items = yourPassedObject
        self.add(asChildViewController: playlist)
        
    }
    
    @objc func openListAudio(notification: Notification){
        guard let yourPassedObject = notification.object as? [SongItem] else {return}
        let playlist = ListPlayAudioViewController.newVC()
        playlist.items = yourPassedObject
        self.add(asChildViewController: playlist)
        
    }
    
    
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    
    
    // Add an observer for LCLLanguageChangeNotification on viewWillAppear. This is posted whenever a language changes and allows the viewcontroller to make the necessary UI updated. Very useful for places in your app when a language change might happen.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //         NotificationCenter.default.addObserver(self, selector: #selector(setBG), name: NSNotification.Name(kBACKGROUBNDIMAGE), object: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //          setBG()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openListVideo(notification:)), name: NSNotification.Name("openList"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openListAudio(notification:)), name: NSNotification.Name("openListAudio"), object: nil)
    }
    
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



//extension RootNavViewController : TSSlidingUpPanelStateDelegate , TSSlidingUpPanelStateDelegate_MP3 {
//    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat) {
//        
//    }
//    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
//        
//    }
//    
//}
