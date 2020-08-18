//
//  PlaylistVideo.swift
//  project
//
//  Created by tranthanh on 5/1/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import os.log

class PlaylistVideo : Codable {
    
    var id: String = ""
    var name: String = ""
    var videos: [Video] = [Video]()
    var image: String = ""
    var count: Int = 0
    
    
    
    init(id: String, title: String, image: String, videos: [Video]) {
        self.id = id
        self.name = title
        self.videos = videos
        self.image = image
        self.count  = videos.count
    }
    
    func getNumberSongText() -> String {
        if(count>1){
            return "\(count) songs"

        }else{
            return "\(count) song"
        }
    }

}


