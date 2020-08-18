//
//  ViewController.swift
//  project
//
//  Created by tranthanh on 4/11/20.
//  Copyright © 2020 tranthanh. All rights reserved.
// APPID  ca-app-pub-8105309887133821~6529376728
// UnitId ca-app-pub-8105309887133821/9882847110

import UIKit



extension UIApplication {
    static func mainVC() -> SUTabBarController? {
        return shared.keyWindow?.rootViewController as? SUTabBarController
    }
  
}

extension ViewController : TSSlidingUpPanelStateDelegate , TSSlidingUpPanelStateDelegate_MP3 {
    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat) {
           
       }
    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        
    }

}

class ViewController: SlideMenuController {
    var isLoading : Bool = false
  
    class func newVC() -> ViewController {
          let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
      return storyBoard.instantiateViewController(withIdentifier: ViewController.className) as! ViewController
    }
    
    
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }
    
     override func awakeFromNib() {
        let leftController =  LeftViewController.newVC()
        self.leftViewController = leftController
        
        let controller = MusicViewController.newVC()
        self.mainViewController =  controller
        super.awakeFromNib()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
//       setSlidingMP3()
//       setSlidingVideo()
     
    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}



