//
//  PlayAudioViewController.swift
//  project
//
//  Created by tranthanh on 4/21/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


extension PlayAudioViewController {
    
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



class PlayAudioViewController: BaseViewController  {
    
  var  item: SongItem!
  var  playlistitems: [SongItem] = []
  var curIndex: Int = 0
  var isShuffle = false
  var isRepeat = false
    
    class func newVC() -> PlayAudioViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: PlayAudioViewController.className) as! PlayAudioViewController
    }
    
    @IBOutlet weak var imgContainer: UIImageView!
    
    @IBAction func closePlayerView(_ sender: Any) {
        UIApplication.mainVC()?.slideUpPanelManagerMp3.changeSlideUpPanelStateTo(toState: .DOCKED)
    }
    
    
    
    
    @IBOutlet weak var miniPlayerView: UIView!
    @IBOutlet weak var maxPlayerStackView: UIStackView!
    
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var btnShuffle: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndtime: UILabel!
    @IBOutlet weak var btnPlayClick: UIButton!
    
    
    // View control player collapse
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblBottomTitle: UILabel!
    @IBOutlet weak var btnPlayBottom: UIButton!
    
    @IBOutlet weak var imageAudio: UIImageView!
    @IBOutlet weak var lblAudio: UILabel!
    
    var isUpdatedFirstTime = false
    //MARK: -viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.mainVC()?.slideUpPanelManagerMp3.slidingUpPanelDraggingDelegate_MP3 = self
        UIApplication.mainVC()?.slideUpPanelManagerMp3.slidingUpPanelAnimationDelegate_MP3 = self
        
        
        self.initPlayerBackground()
        self.initNowPlayingInfor()
        
        
      
        
        
    }
    

    
    // for audio
    var audioPlayer:AVPlayer?
    var timer: Timer?
    var timeObserverToken: Any?
    var nowPlayingInfo: [String : Any]?
    var nowPlayingInfoCenter: MPNowPlayingInfoCenter?
    
    
    
    
    
    
    @IBAction func actionSliderValueChanged(_ sender: UISlider) {
        if audioPlayer != nil {
            audioPlayer!.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: CMTimeScale(1000)), completionHandler: { [weak self](success) in
                guard let self = self else {return}
                if success {
                    DispatchQueue.main.async(execute: { () -> Void in
                        self.updateNowPlayingInfoElapsedTime()
                    })
                }
            })
        }
        
        
    }
    
    
    
    @IBAction func actionPlayBottom(_ sender: UIButton) {
        playAudio()
    }
    @objc func tapPlayView(notification: Notification)  {
        self.prepare(true)
    }
    
    @objc func homeScreenLoaded(notification: Notification) {
        setDataBottomPlayer()
        
    }
    
    
    
    func initPlayerBackground(){
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            UIApplication.shared.beginReceivingRemoteControlEvents()
        } catch {
            print(error)
        }
    }
    
    func initNowPlayingInfor()  {
        if nowPlayingInfo == nil {
            nowPlayingInfo =  [String : Any]()
            nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
        }
    }
    
    
    func registerNotificaton(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.tapPlayView(notification:)), name: NSNotification.Name(NotificationID.PLAYMP3), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.homeScreenLoaded(notification:)), name: NSNotification.Name(NotificationID.DATA_LOADED), object: nil)
    }
    
    
    func setDataBottomPlayer()  {
        guard let imgData = item.imageSound else {return}
        imgThumbnail.image = UIImage(data:  imgData)
        imageAudio.image = UIImage(data: imgData)
        imgContainer.image = UIImage(data:  imgData)
        lblBottomTitle.text = item.songName
        lblAudio.text = item.songName
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
        
    }
    
    func checkFavorited()  {
        
        DispatchQueue.global(qos: .background).async {
            if FAVORITED_NHACMP3.contains(where: { $0.songName == self.item.songName && $0.artistName == self.item.artistName}) {
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
        if !FAVORITED_NHACMP3.contains(where: { $0.songName == self.item.songName && $0.artistName == self.item.artistName}) {
            FAVORITED_NHACMP3.append(item)
            self.btnFavorite.setImage(UIImage(named: "icons8-red_heart"), for: .normal)
            self.showToast(message: "Favourited")
        }else{
            let size = FAVORITED_NHACMP3.count
            for i in 0...size {
                let song = FAVORITED_NHACMP3[i]
                if song.id == item.id{
                     FAVORITED_NHACMP3.remove(at: i)
                    break
                }
            }
            btnFavorite.setImage(UIImage(named: "icons8-heart_outline"), for: .normal)
            showToast(message: "Un Favourited")
        }
    }
    
    
    
    
    @IBAction func btnListAudioMini(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("openListAudio"), object: playlistitems, userInfo: nil)
    }
    
    @IBAction func btnListAudio(_ sender: Any) {
        let playlist = ListPlayAudioViewController.newVC()
        playlist.items = self.playlistitems
        self.add(asChildViewController: playlist)
    }
    
    @IBAction func actionFavorite(_ sender: UIButton) {
        setFavorite()
    }
    
}


// processing lockscreen
extension PlayAudioViewController{
    
    func updateNowPlayingInfoCenter(image: UIImage?) {
        // Define Now Playing Info
        nowPlayingInfo![MPMediaItemPropertyTitle] = item.songName
        nowPlayingInfo![MPMediaItemPropertyArtist] = item.artistName
        nowPlayingInfo![MPMediaItemPropertyPlaybackDuration] = self.audioPlayer?.currentItem?.asset.duration.seconds
        
        // Set the metadata
        
        if let imageSet = image{
            nowPlayingInfo![MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image!.size) { size in
                    return imageSet
            }
            
        }else{
            imageFromServerURL(item: item)
        }
        
        self.configureNowPlayingInfo(nowPlayingInfo)
        self.setupRemoteTransportControls()
    }
    
    
    func updateNowPlayingInfoElapsedTime() {
        DispatchQueue.main.async(execute: { () -> Void in
            guard var nowPlayingInfo = self.nowPlayingInfo  else { return }
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.audioPlayer?.currentTime().seconds
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.audioPlayer?.currentItem?.asset.duration.seconds
            self.configureNowPlayingInfo(nowPlayingInfo)
        })
    }
    
    func updateNowPlayingInfoElapsedTimeReset() {
        DispatchQueue.main.async(execute: { () -> Void in
            guard var nowPlayingInfo = self.nowPlayingInfo else { return }
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = 0
            self.configureNowPlayingInfo(nowPlayingInfo)
        })
    }
    
    func configureNowPlayingInfo(_ nowPlayingInfo: [String: Any]?) {
        self.nowPlayingInfoCenter!.nowPlayingInfo = nowPlayingInfo
        self.nowPlayingInfo = nowPlayingInfo
    }
    
    public func imageFromServerURL(item: SongItem) {
        guard let imgData = item.imageSound else {return}
        let image = UIImage(data: imgData)
        self.updateNowPlayingInfoCenter(image: image)
    }
    
    func setupRemoteTransportControls() {
        UIApplication.shared.beginReceivingRemoteControlEvents();
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.audioPlayer!.rate == 0.0 {
                self.playAudio()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.audioPlayer!.rate == 1.0 {
                self.playAudio()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            if self.audioPlayer!.rate == 1.0 {
                self.nextAudio()
                return .success
            }
            return .commandFailed
        }
        
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            if self.audioPlayer!.rate == 1.0 {
                self.prevAudio()
                return .success
            }
            return .commandFailed
        }
        
        // Scrubber
        commandCenter.changePlaybackPositionCommand.addTarget { [weak self](remoteEvent) -> MPRemoteCommandHandlerStatus in
            guard let self = self else {return .commandFailed}
            if let player = self.audioPlayer {
                let playerRate = player.rate
                if let event = remoteEvent as? MPChangePlaybackPositionCommandEvent {
                    player.seek(to: CMTime(seconds: event.positionTime, preferredTimescale: CMTimeScale(1000)), completionHandler: { [weak self](success) in
                        guard let self = self else {return}
                        if success {
                            DispatchQueue.main.async(execute: { () -> Void in
                                self.updateNowPlayingInfoElapsedTime()
                            })
                            self.audioPlayer?.rate = playerRate
                            
                        }
                    })
                    return .success
                }
            }
            return .commandFailed
        }
    }
    
    // process player
    func processPlayAudio(item: SongItem){
        
        DispatchQueue.global(qos: .background).async {
            let playItem = AVPlayerItem(url: URL(string: item.songPath)!)
            if self.audioPlayer == nil{
                self.audioPlayer = AVPlayer()
            }
            self.audioPlayer?.replaceCurrentItem(with: playItem)
            DispatchQueue.main.async {
                self.audioPlayer!.play()
                self.setDataAudio(item: item)
                self.audioPlayer?.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.new, .initial], context: nil)
                self.audioPlayer?.addObserver(self, forKeyPath: #keyPath(AVPlayer.currentItem.status), options:[.new, .initial], context: nil)
                // Watch notifications
                let center = NotificationCenter.default
                center.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.audioPlayer?.currentItem)
                
            }
        }
        
    }
    
    
    func addPeriodicTimeObserver() {
        if let currentItem = self.audioPlayer!.currentItem {
            let dTotalSeconds = currentItem.asset.duration.seconds
            if !dTotalSeconds.isNaN{
                setTimeLabelTotal(second: Int(dTotalSeconds.rounded(.up)))
                
            }
            // Notify every one second
            let timeScale = CMTimeScale(NSEC_PER_SEC)
            let time = CMTime(seconds: 1, preferredTimescale: timeScale)
            timeObserverToken = audioPlayer?.addPeriodicTimeObserver(forInterval: time,
                                                                     queue: .main) {[weak self] time in
                                                                        self?.setTimeLabel(time: time)
            }
        }
    }
    
    func setTimeLabel(time: CMTime)  {
        slider.value = Float(time.seconds)
        let dMinutes = self.getStringFrom(seconds: Int(time.seconds) % 3600 / 60);
        let dSeconds = self.getStringFrom(seconds: Int(time.seconds) % 3600 % 60);
        self.lblStartTime.text = "\(dMinutes):\(dSeconds)"
        
        if !isUpdatedFirstTime{
            self.updateNowPlayingInfoElapsedTime()
            isUpdatedFirstTime = true
        }
        
    }
    
    
    func setTimeLabelTotal(second: Int)  {
        let dMinutes = self.getStringFrom(seconds: second % 3600 / 60);
        let dSeconds = self.getStringFrom(seconds: second % 3600 % 60);
        self.lblEndtime.text = "\(dMinutes):\(dSeconds)"
        slider.maximumValue = Float(second)
    }
    
    func getStringFrom(seconds: Int) -> String {
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            audioPlayer?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            // Switch over status value
            switch status {
            case .readyToPlay:
                setStatePlayButton(isPlaying: true)
                setNextPrevState(isReady: true)
                addPeriodicTimeObserver()
                
                break
            case .failed:
                showToast(message: "Can not play this song")
                print("ee: Can not play this song")
                break
            case .unknown:
                print("ee: unknown")
                break
            @unknown default:
                break
            }
        }
        
    }
    
    func processCancelPlayer()  {
        if audioPlayer != nil{
            audioPlayer?.pause()
            isUpdatedFirstTime = false
            updateNowPlayingInfoCenter(image: nil)
            updateNowPlayingInfoElapsedTimeReset()
            removePeriodicTimeObserver()
        }
    }
    
    func setDataAudio(item: SongItem)  {
        lblAudio.text = item.songName
        slider.value = 0
        lblEndtime.text = "00:00"
        lblStartTime.text = "00:00"
    }
    
    func stopAllPlayer()  {
        if audioPlayer != nil {
            isUpdatedFirstTime = false
            removePeriodicTimeObserver()
            audioPlayer?.pause()
            updateNowPlayingInfoElapsedTimeReset()
        }
        
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        nextAudio()
    }
    
    
    
    
    
    func playAudio()  {
        if audioPlayer?.isAudioAvailable() ?? false {
            print("isAudioAvailable")
            if audioPlayer?.timeControlStatus == .playing {
                audioPlayer?.pause()
                setStatePlayButton(isPlaying: false)
            }else{
                audioPlayer?.play()
                setStatePlayButton(isPlaying: true)
            }
        }else {
            print("no content")
            prepare(false)
        }
    }
    
    func setStatePlayButton(isPlaying: Bool)  {
        if isPlaying{
            btnPlayClick.setImage(UIImage(named: "icons8-pause"), for: .normal)
            btnPlayBottom.setImage(UIImage(named: "icons8-pause"), for: .normal)
        }else{
            btnPlayClick.setImage(UIImage(named: "icons8-play"), for: .normal)
            btnPlayBottom.setImage(UIImage(named: "icons8-play"), for: .normal)
        }
    }
    
    func setNextPrevState(isReady: Bool)  {
        if isReady {
            btnNext.isEnabled = true
            btnPrev.isEnabled = true
        }else{
            btnNext.isEnabled = false
            btnPrev.isEnabled = false
        }
    }
    
    func setStateProgressView(isShow: Bool)  {
        if isShow{
            
        }
    }
    
    func prepare(_ isOpen : Bool)  {
        processCancelPlayer()
        setNextPrevState(isReady: false)
        setDataBottomPlayer()
        updateNowPlayingInfoCenter(image: nil)
        checkFavorited()
        processPlayAudio(item: item)
    }
    
    
}


extension PlayAudioViewController : TSSlidingUpPanelDraggingDelegate_MP3,TSSlidingUpPanelAnimationDelegate_MP3 {
    func slidingUpPanelAnimationStart(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat) {
        
    }
    
    func slidingUpPanelAnimationFinished(withDuration: TimeInterval, slidingUpCurrentPanelState: SLIDE_UP_PANEL_STATE_MP3, yPos: CGFloat) {
        if UIApplication.mainVC()?.slideUpPanelManagerMp3.slideUpPanelState_MP3 == SLIDE_UP_PANEL_STATE_MP3.OPENED {
            miniPlayerView.isHidden = true
            maxPlayerStackView.isHidden = false
        }else{
            miniPlayerView.isHidden = false
            maxPlayerStackView.isHidden = true
        }
    }
    
    func slidingUpPanelStartDragging(startYPos: CGFloat) {
        
    }
    
    func slidingUpPanelDraggingVertically(yPos: CGFloat) {
        
    }
    
    func slidingUpPanelDraggingFinished(delta: CGFloat) {
        
    }
    
    
    
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}


