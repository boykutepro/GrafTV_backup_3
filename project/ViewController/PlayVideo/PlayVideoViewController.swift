//
//  PlayAudioViewController.swift
//  project
//
//  Created by tranthanh on 4/18/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import GoogleMobileAds





extension PlayVideoViewController {
    
    func setPosCurrentVideoRandom()  {
        curIndex = Int(arc4random_uniform(UInt32(playlistitems.count)));
    }
    
    func nextAudio()  {
        if (isShuffle) {
            setPosCurrentVideoRandom();
        } else {
            if (!isRepeat) {
                if playlistitems.count == 1{
                    curIndex = 0
                }else if (curIndex < playlistitems.count - 1) {
                    curIndex += 1
                } else {
                    curIndex = 0
                }
                self.item = playlistitems[curIndex]
                prepare(true)
            }
        }
    }
    
    func prevAudio() {
        if (isShuffle) {
            setPosCurrentVideoRandom();
        } else {
            if (!isRepeat) {
                if playlistitems.count == 1{
                    curIndex = 0
                }else if (curIndex > 0) {
                    curIndex -= 1
                } else {
                    curIndex = playlistitems.count - 1
                }
                self.item = playlistitems[curIndex]
                prepare(true)
            }
        }
    }
    
}
extension PlayVideoViewController : GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("receiveAd")
        
    }
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
    
}

class PlayVideoViewController: BaseViewController  {
    //    let viewContainer = UIView()
    var item: Video!
    var playlistitems: [Video] = []

    var curIndex: Int = 0
    var isShuffle = false
    var isRepeat = false
    var isPlay = true
    
    var isFullscreen  = false
    
    @IBOutlet weak var btnFullScreen: UIButton!
    
    @IBOutlet weak var viewContainerActionFullVideo: UIView!
    
    
    @IBAction func exitFullScreen(_ sender: Any) {
        updateUI(false)
    }
    @IBOutlet weak var slideActionFull: UISlider!
    
    @IBAction func slideFullScreen(_ sender: Any) {
        ytPlayer.duration { (duration, error) in
            let seekToTime = Float(duration) * self.slideActionFull.value
            self.ytPlayer.seek(toSeconds: seekToTime, allowSeekAhead: true)
        }
        
        
    }
    
    
    @IBOutlet weak var btnPlayFullScreen: UIButton!
    @IBAction func btnPlayFullScreen(_ sender: Any) {
        playAudio()
    }
    @IBOutlet weak var endTimeFullScreen: UILabel!
    @IBOutlet weak var startTimeFullScreen: UILabel!
    @IBOutlet weak var viewActionFullVideo: UIView!
    
    func updateUI(_ isForFullScreen: Bool) {
        isFullscreen = isForFullScreen
        btnFullScreen.isSelected = isForFullScreen
        if isForFullScreen {
            viewActionFullVideo.isHidden = false
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(showAction), userInfo: nil, repeats: false)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            ytPlayer.snp.remakeConstraints { (make) in
                make.edges.equalToSuperview()
            }
//            UIApplication.mainVC()?.slideUpPanelManagerVideo.overlayPanGR.isEnabled = false
        } else {
            viewActionFullVideo.isHidden = true
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            ytPlayer.snp.remakeConstraints { (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(viewTitle.snp.bottom).offset(10)
                make.centerX.equalToSuperview()
                make.height.equalTo(ytPlayer.snp.width).multipliedBy(9.0/16.0).priority(500)
            }
//            UIApplication.mainVC()?.slideUpPanelManagerVideo.overlayPanGR.isEnabled = true
        }
    }
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var ytPlayer: YTPlayerView!
    
    class func newVC() -> PlayVideoViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: PlayVideoViewController.className) as! PlayVideoViewController
    }
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewLike: UIView!
    
    @IBOutlet var viewContainer: UIView! = {
        let view = UIView ()
        return view
    }()
    
    @IBOutlet weak var viewMax: UIView!
    @IBOutlet weak var viewFullScreen: UIView!
    @IBAction func closePlayerView(_ sender: Any) {
        UIApplication.mainVC()?.slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: .DOCKED)
    }
    
    @IBOutlet weak var miniPlayerView: UIView!

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnShuffle: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndtime: UILabel!
    @IBOutlet weak var btnPlayClick: UIButton!
    @IBOutlet weak var lblVideo: UILabel!
    
    
    @IBOutlet weak var imgContainer: UIImageView!
    
    
    var playerVars: [String:Any] = [
        "autoplay": 1,
        "playsinline" : 1,
        "enablejsapi": 0,
        "wmode": "transparent",
        "controls": 0,
        "showinfo": 0,
        "rel": 0,
        "modestbranding": 0,
        "iv_load_policy": 3 //annotations
    ]
    // View control player collapse
    @IBOutlet weak var lblBottomTitle: UILabel!
    @IBOutlet weak var btnPlayBottom: UIButton!
    var isUpdatedFirstTime = false
    
    //MARK: -viewDidLoad
    var tab : UITapGestureRecognizer?
    
    var tabMini : UITapGestureRecognizer?
    func setupViewContainer(){
        view.addSubview(viewContainer)
        viewContainer.backgroundColor = .red
        viewContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        viewContainer.addSubview(viewMax)
        viewMax.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewActionFullVideo.isHidden = true
        UIApplication.mainVC()?.slideUpPanelManagerVideo.slidingUpPanelDraggingDelegate = self
        UIApplication.mainVC()?.slideUpPanelManagerVideo.slidingUpPanelAnimationDelegate = self
        
        self.ytPlayer.delegate = self
        setupBannerView()
        setUpGoooleAdsMod()
        
        
        tab = UITapGestureRecognizer(target: self, action: #selector(self.closePopup(sender:)))
        tab?.numberOfTapsRequired = 1
        tab?.cancelsTouchesInView = false
        viewActionFullVideo.addGestureRecognizer(tab!)
       
        tabMini = UITapGestureRecognizer(target: self, action: #selector(self.fullView))
        tabMini?.numberOfTapsRequired = 1
        miniPlayerView.addGestureRecognizer(tabMini!)
        
    }
    
    @objc func fullView(){
        UIApplication.mainVC()?.slideUpPanelManagerVideo.changeSlideUpPanelStateTo(toState: SLIDE_UP_PANEL_STATE.OPENED)
    }
    
    @objc func showAction() {
        stackViewActionFullScreen.isHidden = true
        btnExitFullScreen.isHidden = true
        btnPlayFullScreen.isHidden = true
    }
    
    
    
    @IBOutlet weak var btnExitFullScreen: UIButton!
    
    
    @IBOutlet weak var stackViewActionFullScreen: UIStackView!
    @objc func closePopup(sender : UIGestureRecognizer){
        if (tab?.cancelsTouchesInView)! {
            
            stackViewActionFullScreen.isHidden = true
            btnExitFullScreen.isHidden = true
            btnPlayFullScreen.isHidden = true
            Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showAction), userInfo: nil, repeats: false)
            tab?.cancelsTouchesInView = false
        }else{
            stackViewActionFullScreen.isHidden = false
            btnPlayFullScreen.isHidden = false
            btnExitFullScreen.isHidden = false
            Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showAction), userInfo: nil, repeats: false)
            tab?.cancelsTouchesInView = true
            
        }
    }
    
    func setUpGoooleAdsMod() {
        bannerView.adUnitID = "ca-app-pub-5983740188037809/9808045714"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func setupBannerView(){
        bannerView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(viewLike.snp.top).offset(1)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
    }
    
    
    func setDataBottomPlayer()  {
        if item.etag.isEqual(""){
                  if item.uri.isEqual(""){
                       lblBottomTitle.text = item.name
                  } else {
                         lblBottomTitle.text = item.name
                  }
              } else {
                    lblBottomTitle.text = item.snippet.title
              }
      
    }
    
    
    func prepare(_ isOpen : Bool)  {
        updateUI(false)
        processCancelPlayer()
        setDataBottomPlayer()
        checkFavorited()
        processPlayVideo(item: self.item , playVar:  self.playerVars)
    }
    
    
    func setStatePlayButton(isPlaying: Bool)  {
        if isPlaying {
            self.btnPlayClick.setImage(#imageLiteral(resourceName: "icons8-pause"), for: .normal)
            self.btnPlayBottom.setImage(#imageLiteral(resourceName: "icons8-pause"), for: .normal)
            self.btnPlayFullScreen.setImage(#imageLiteral(resourceName: "icons8-pause"), for: .normal)
        }else{
            self.btnPlayClick.setImage(#imageLiteral(resourceName: "icons8-play"), for: .normal)
            self.btnPlayBottom.setImage(#imageLiteral(resourceName: "icons8-play"), for: .normal)
            self.btnPlayFullScreen.setImage(#imageLiteral(resourceName: "icons8-play"), for: .normal)
        }
    }
    
    func playAudio()  {
        ytPlayer.playerState { (playerState, error) in
            if playerState == .paused {
                self.ytPlayer.playVideo()
                self.setStatePlayButton(isPlaying: true)
            } else {
                self.ytPlayer.pauseVideo()
                self.setStatePlayButton(isPlaying: false)
            }
        }
        
    }
    
    func processPlayVideo(item: Video , playVar : [String:Any]){
        if item.etag.isEqual(""){
            if item.uri.isEqual("") {
                APIService.shared.getKeyYoutube(keyword: item.name) { [weak self] (id) in
                    if let self = self , let id = id {
                        if id != "" {
                            DispatchQueue.main.async {
                                        self.ytPlayer.load(withVideoId: id, playerVars: playVar)
                                        self.setDataAudio(item: item)
                                                   }
                        } else {
                            DispatchQueue.main.async {
                                self.ytPlayer.load(withVideoId: item.song_url, playerVars: playVar)
                                    self.setDataAudio(item: item)
                                                                             }
                        }
                       
                    }
                }
            } else {
                SearchSpotifyDataStore.share.getYoutubeIdSporty(keyword: item.name, spotify_track_id: item.id) { (item) in
                        if let item = item  {
                            self.ytPlayer.load(withVideoId:  item.youtubeId, playerVars: playVar)
                            }
                }
               self.setDataAudio(item: item)
            }
        } else {
            self.ytPlayer.load(withVideoId: item.idKaraoke.videoId, playerVars: playVar)
             self.setDataAudio(item: item)
        }
        
    }
    
    func processCancelPlayer()  {
        if ytPlayer != nil{
            ytPlayer.pauseVideo()
            isUpdatedFirstTime = false
        }
    }
    
    func setDataAudio(item: Video)  {
        if item.etag.isEqual(""){
            if item.uri.isEqual(""){
                lblVideo.text = item.name
            } else {
                 lblVideo.text = item.name
            }
        } else {
            lblVideo.text = item.snippet.title
        }
     
        slider.value = 0
        lblEndtime.text = "00:00"
        lblStartTime.text = "00:00"
    }
    
    func checkShuffle()  {
        let isShuffle = DataStoreManager.shared().isShuffe()
        setShuffle(isShuffle: isShuffle)
    }
    
    func setShuffle(isShuffle: Bool)  {
        if isShuffle {
            btnShuffle.setImage(UIImage(named:"ic_shuffled"), for: .normal)
        }else{
            btnShuffle.setImage(UIImage(named: "ic_shuffle"), for: .normal)
        }
        self.isShuffle = isShuffle
        DataStoreManager.shared().saveShuffe(isKeep: isShuffle)
    }
    
    
    
    
    func checkFavorited()  {
        DispatchQueue.global(qos: .background).async {
            if FAVORITED_VIDEO.contains(where: { $0.id == self.item.id }) {
                DispatchQueue.main.async {
                    self.btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
                }
            }else{
                DispatchQueue.main.async {
                    self.btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
                }
            }
        }
    }
    
    func setFavorite() {
        if !FAVORITED_VIDEO.contains(where: { $0.id == item.id }) {
            FAVORITED_VIDEO.append(item)
            btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
            showToast(message: "Favourited")
        }else{
            let size = FAVORITED_VIDEO.count
            for i in 0...size {
                let song = FAVORITED_VIDEO[i]
                if song.id == item.id{
                    FAVORITED_VIDEO.remove(at: i)
                    break
                }
            }
            btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
            showToast(message: "Un Favourited")
        }
    }
    
    
    @IBAction func actionShare(_ sender: Any) {
        self.shareButtonClicked(item: item )
    }
    
    
    @IBAction func actionPlay(_ sender: UIButton) {
        playAudio()
    }
    
    @IBAction func actionNext(_ sender: UIButton) {
        nextAudio()
    }
    
    @IBAction func actionPrev(_ sender: UIButton) {
        prevAudio()
    }
    
    @IBAction func actionShuffer(_ sender: UIButton) {
        performShuffer()
    }
    
    func performShuffer()  {
        setShuffle(isShuffle: !isShuffle)
        if isShuffle {
            showToast(message: "Shuffle: OFF")
        }else{
            showToast(message: "Shuffle: ON")
        }
    }
    
    @IBAction func btnListBottom(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("openList"), object: playlistitems, userInfo: nil)
    }
    
    @IBAction func btnList(_ sender: Any) {
        let playlist = ListPlayVideoViewController.newVC()
        playlist.items = self.playlistitems
        self.add(asChildViewController: playlist)
    }
    
    @IBAction func actionSliderValueChanged(_ sender: UISlider) {
        ytPlayer.duration { (duration, error) in
            let seekToTime = Float(duration) * self.slider.value
            self.ytPlayer.seek(toSeconds: seekToTime, allowSeekAhead: true)
        }
    }
    
    
    
    @IBAction func actionPlayBottom(_ sender: UIButton) {
        playAudio()
    }
    
    
    @IBAction func actionFullscreen(_ sender: Any) {
        updateUI(true)
    }
    
    
    
    @IBAction func actionPopUpAddPlayList(_ sender: Any) {
        self.showPlaylistOff(item: item)
    }
    
    
    @IBAction func actionFavorite(_ sender: UIButton) {
        setFavorite()
    }
    
}


extension PlayVideoViewController : TSSlidingUpPanelDraggingDelegate,TSSlidingUpPanelAnimationDelegate {
    func slidingUpPanelStartDragging(startYPos: CGFloat) {
        //
    }
    
    func slidingUpPanelDraggingVertically(yPos: CGFloat) {
        //
    }
    
    func slidingUpPanelDraggingFinished(delta: CGFloat) {
        //
    }
    
    func slidingUpPanelAnimationStart(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        //
    }
    
    func slidingUpPanelAnimationFinished(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
        //
    }
    
    
}


//TSSlidingUpPanelDraggingDelegate,TSSlidingUpPanelAnimationDelegate {
//    func slidingUpPanelStartDragging(startYPos: CGFloat) {
////        print("startYPos",startYPos)
//    }
//
//    func slidingUpPanelDraggingVertically(yPos: CGFloat) {
////        print("syPos",yPos)
//    }
//
//    func slidingUpPanelDraggingFinished(delta: CGFloat) {
////        print("syPos",delta)
//    }
//
//    func slidingUpPanelAnimationStart(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
//
//
//    }
//
//    func slidingUpPanelAnimationFinished(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE, yPos: CGFloat) {
//        if UIApplication.mainVC()?.slideUpPanelManagerVideo.slideUpPanelState == SLIDE_UP_PANEL_STATE.OPENED {
//            viewActionFullVideo.isHidden = true
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//            viewActionFullVideo.isHidden = true
//            miniPlayerView.isHidden = true
//            ytPlayer.snp.remakeConstraints { (make) in
//                make.left.equalTo(20)
//                make.right.equalTo(-20)
//                make.top.equalTo(viewTitle.snp.bottom).offset(10)
//                make.centerX.equalToSuperview()
//                make.height.equalTo(ytPlayer.snp.width).multipliedBy(9.0/16.0).priority(500)
//            }
//            miniPlayerView.isHidden = true
//            viewFullScreen.isHidden = false
//        } else if  UIApplication.mainVC()?.slideUpPanelManagerVideo.slideUpPanelState == SLIDE_UP_PANEL_STATE.DOCKED {
//            viewActionFullVideo.isHidden = true
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//            viewFullScreen.isHidden = true
//            viewTitle.isHidden = true
//            miniPlayerView.isHidden = false
//            ytPlayer.snp.remakeConstraints { (make) in
//                make.left.top.equalTo(0)
//                make.height.equalTo(64)
//                make.width.equalTo(113)
//            }
//
//        }
//    }
//}
//
//
extension PlayVideoViewController : YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }

    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        ytPlayer.duration { (duration, error) in
            let progress = playTime/Float(duration)
            self.slider.value = progress
            self.slideActionFull.value = progress
            self.lblEndtime.text = Int(duration).toAudioString
            self.endTimeFullScreen.text = Int(duration).toAudioString
        }
        self.lblStartTime.text = Int(playTime).toAudioString
        self.startTimeFullScreen.text = Int(playTime).toAudioString
    }

    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            self.isPlay = true
            setStatePlayButton(isPlaying: true)
        case .paused:
            self.isPlay = false
            setStatePlayButton(isPlaying: false)
        case .ended:
            nextAudio()
        default:
            break
        }
    }

    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .clear
    }



}


extension Int {
    var toAudioString: String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        return h > 0 ? String(format: "%1d:%02d:%02d", h, m, s) : String(format: "%1d:%02d", m, s)
    }
}



