//
//  MusicViewController.swift
//  project
//
//  Created by tranthanh on 4/17/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import Parchment


class MusicViewController: BaseViewController {
    
    
    class func newVC() ->  MusicViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:  MusicViewController.className) as!  MusicViewController
    }
    
    
  
    
    @IBAction func btnMenu(_ sender: Any) {
//        self.slideMenuController()?.openLeft()
        print("pressed menu")
        let settingVC = LeftViewController.newVC()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        lblTitle.text = "Graf TV"
        createPageMenu()
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
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
        
   
    
  @IBOutlet weak var containerView: UIView!
    
    func createPageMenu(){
        let controller1  = HomeViewController.newVC()
        controller1.title = "Home"
        let controller2 = KaraokeViewController.newVC()
        controller2.title = "Karaoke"
        
        let pagingViewController = PagingViewController(viewControllers: [
            controller1 , controller2
        ])
        
        
        addChild(pagingViewController)
        containerView.addSubview(pagingViewController.view)
        containerView.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
       
//        
        // Customize the menu styling.
        pagingViewController.selectedTextColor = .white
        pagingViewController.textColor = .white
        pagingViewController.backgroundColor = .clear
        pagingViewController.menuBackgroundColor = .clear
        pagingViewController.selectedBackgroundColor = .clear
        pagingViewController.indicatorColor = UIColor.white
        pagingViewController.borderColor = .clear
        pagingViewController.indicatorOptions = .visible(
            height: 3,
            zIndex: Int.max,
            spacing: .zero,
            insets: .zero
        )
     }
}

