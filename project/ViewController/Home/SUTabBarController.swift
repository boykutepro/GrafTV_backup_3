//
//  SUTabBarController.swift
//  project
//
//  Created by Thien Tung on 8/15/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class SUTabBarController: UITabBarController, TSSlidingUpPanelStateDelegate {
    
    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        
    }
    
//    var slidingUpVC: PlayVideoViewController!
//
//    let slideUpPanelManager: TSSlidingUpPanelManager = TSSlidingUpPanelManager.with
    
    @IBOutlet weak var suTabBar: UITabBar!
    
    var slidingUpVC = PlayVideoViewController.newVC()
    var slidingUpVCAudio = PlayAudioViewController.newVC()
    let slideUpPanelManagerVideo: TSSlidingUpPanelManager = TSSlidingUpPanelManager.with
    let slideUpPanelManagerMp3: TSSlidingUpPanelManager_MP3 = TSSlidingUpPanelManager_MP3.with
    
    class func newVC() -> SUTabBarController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: SUTabBarController.className) as! SUTabBarController
    }
    
    var itemVideo =  [Video]()
      var itemSong = [Song]()
      
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        slidingUpVC = PlayVideoViewController.newVC()
        
        slideUpPanelManagerVideo.slidingUpPanelStateDelegate = self
        
        slideUpPanelManagerVideo.initPanelWithTabBar(inView: view, tabBar: suTabBar, slidingUpPanelView: slidingUpVC.view, slidingUpPanelHeaderSize: 64)
        
        slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.DOCKED)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setSlidingMP3()
        setSlidingVideo()
        
        
    }
      
        func maximizePlayerDetailsVideo(item: Video?, playlistitems: [Video] = []) {
            slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.OPENED)
            if item != nil {
                slidingUpVC.item = item
            }
            slidingUpVC.playlistitems = playlistitems
            slidingUpVC.prepare(true)
            slideUpPanelManagerMp3.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE_MP3.CLOSED)
        }
        
        func maximizePlayerDetailsMp3(item: SongItem?, playlistitems: [SongItem] = []) {
            slideUpPanelManagerMp3.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE_MP3.OPENED)
            if item != nil {
                slidingUpVCAudio.item = item
            }
            
            slidingUpVCAudio.playlistitems = playlistitems
            slidingUpVCAudio.prepare(true)
            slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.CLOSED)
        }
        
        
        func setSlidingVideo(){
            slideUpPanelManagerVideo.slidingUpPanelStateDelegate = self
    //        slideUpPanelManagerVideo.initPanelWithView(inView: view, slidingUpPanelView: slidingUpVC.view, slidingUpPanelHeaderSize: 64)
            
            slideUpPanelManagerVideo.initPanelWithTabBar(inView: view, tabBar: suTabBar, slidingUpPanelView: slidingUpVC.view, slidingUpPanelHeaderSize: 64)
            
            if slidingUpVCAudio.audioPlayer?.isPlaying == true  {
                slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.CLOSED)
            } else if slidingUpVC.isPlay == false {
                slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.DOCKED)
            }  else {
                slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.CLOSED)
            }
        }
        
        
        func setSlidingMP3(){
            slideUpPanelManagerMp3.slidingUpPanelStateDelegate_MP3 = self
            slideUpPanelManagerMp3.initPanelWithView(inView: view, slidingUpPanelView: slidingUpVCAudio.view, slidingUpPanelHeaderSize: 64)
            if slidingUpVCAudio.audioPlayer?.isPlaying == true {
                slideUpPanelManagerMp3.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE_MP3.DOCKED)
            } else {
                slideUpPanelManagerMp3.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE_MP3.CLOSED)
            }
            
        }
}

extension SUTabBarController :  TSSlidingUpPanelStateDelegate_MP3 {
    func slidingUpPanelStateChanged(slidingUpPanelNewState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat) {
        
    }
    
    
}
