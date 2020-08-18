//
//  AdModDelegate.swift
//  project
//
//  Created by tranthanh on 5/19/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import GoogleMobileAds

//Define admobdelegate as global variable
var admobDelegate = AdMobDelegate()

//Declare a global variable currentVc to hold reference to current view controller
var currentVc: UIViewController!


class AdMobDelegate: NSObject, GADInterstitialDelegate {

    var interstitialView: GADInterstitial!

    func createAd() -> GADInterstitial {
        interstitialView = GADInterstitial(adUnitID:"ca-app-pub-5983740188037809/1929555698")
        interstitialView.delegate = self
        let request = GADRequest()
        interstitialView.load(request)
        return interstitialView
    }
    
    
  

    func showAd() {
        if interstitialView != nil {
            if (interstitialView.isReady == true){
                interstitialView.present(fromRootViewController:currentVc)
            } else {
                print("ad wasn't ready")
                interstitialView = createAd()
            }
        } else {
            print("ad wasn't ready")
            interstitialView = createAd()
        }
    }
//
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Ad Received")
        if ad.isReady {
            interstitialView.present(fromRootViewController: currentVc)
        }
   }
//
//    func interstitialDidDismissScreen(_ ad: GADInterstitial!) {
//        print("Did Dismiss Screen")
//    }
//
//    func interstitialWillDismissScreen(_ ad: GADInterstitial!) {
//        print("Will Dismiss Screen")
//    }
//
//    func interstitialWillPresentScreen(_ ad: GADInterstitial!) {
//        print("Will present screen")
//    }
//
//    func interstitialWillLeaveApplication(_ ad: GADInterstitial!) {
//        print("Will leave application")
//    }
//
//    func interstitialDidFail(toPresentScreen ad: GADInterstitial!) {
//        print("Failed to present screen")
//    }
//
//    func interstitial(_ ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
//        print("\(String(describing: ad)) did fail to receive ad with error \(String(describing: error))")
//    }
}
