//
//  AppDelegate.swift
//  project
//
//  Created by tranthanh on 4/11/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireNetworkActivityLogger
import IQKeyboardManagerSwift
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        // start logging api when call api (user Alamofire )
        NetworkActivityLogger.shared.startLogging()
        setupKeyboardManager()
        configApp(application)
        return true
    }
    private func setupKeyboardManager() {
                 IQKeyboardManager.shared.enable = true
                 IQKeyboardManager.shared.enableAutoToolbar = false
                 IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
//                 IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
                 IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func configApp(_ application: UIApplication){
        
        //FAVORITED LIST
        
         FAVORITED_VIDEO =   get_FAVORITED_VIDEO() ?? []
         FAVORITED_CHART =   get_FAVORITED_CHART() ?? []
         FAVORITED_GENRES =  get_FAVORITED_GENRES() ?? []
         FAVORITED_ARTIST  =   get_FAVORITED_ARTIST() ?? []
//        listPlaylists = get_ListPlaylists() ?? []
    
        
        //FAVORITED LIST
        if let bookmarkData = UserDefaults.standard.value(forKey: "FAVORITED_SONG") as? [[String: AnyObject]] {
            for book in bookmarkData {
                FAVORITED_SONG.append(Song(data: book))
            }
        }
        
        if let bookmarkData = UserDefaults.standard.value(forKey: "DOWNLOADED_SONG") as? [[String: AnyObject]] {
            for book in bookmarkData {
                DOWNLOADED_SONG.append(Song(data: book))
            }
        }
        
        if let bookmarkData = UserDefaults.standard.value(forKey: "ARTISTS") as? [[String: AnyObject]] {
            for book in bookmarkData {
                ARTISTS.append(Artist(data: book))
            }
        }
        
        
        if let bookmarkData = UserDefaults.standard.value(forKey: "FAVORITED_NHACMP3") as? [[String: AnyObject]] {
                   for book in bookmarkData {
                      FAVORITED_NHACMP3.append(SongItem(data: book))
                   }
               }
        
        
    }
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


class WallpaperWindow: UIWindow {
    
//    var wallpaper: UIImageView = {
//        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
//        backgroundImage.image = UIImage(named: "girl1")
//        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
//        return backgroundImage
//        }() {
//        didSet {
//
//        }
//    }
    
    
//
//
//
//    var wallpaper: UIImage? = UIImage(data:  UserDefaults.standard.object(forKey: kBACKGROUBNDIMAGE) as! Data ) {
//        didSet {
//            // refresh if the image changed
//            setNeedsDisplay()
//        }
//    }
//
//    init() {
//        super.init(frame: UIScreen.main.bounds)
//        //clear the background color of all table views, so we can see the background
//        UITableView.appearance().backgroundColor = UIColor.clear
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func draw(_ rect: CGRect) {
//        // draw the wallper if set, otherwise default behaviour
//        if let wallpaper = wallpaper {
//            wallpaper.draw(in: self.bounds);
//        } else {
//            super.draw(rect)
//        }
//    }
}
