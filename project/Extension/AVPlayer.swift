//
//  AVPlayer.swift
//  project
//
//  Created by tranthanh on 4/18/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//



import UIKit
import AVFoundation
import MediaPlayer

extension AVPlayer {
    var getIsPlaying:Bool {
        return rate != 0 && error == nil
    }
    
    func isAudioAvailable() -> Bool{
           return self.currentItem?.asset.tracks.filter({$0.mediaType == AVMediaType.audio}).count != 0
    }

       func isVideoAvailable() -> Bool {
           return self.currentItem?.asset.tracks.filter({$0.mediaType == AVMediaType.video}).count != 0
    }
}
