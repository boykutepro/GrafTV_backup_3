//
//  QueuItemYouTube.swift
//  project
//
//  Created by tranthanh on 4/27/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

//class QueuItemYoutube {
//    func notificationForUpdate()  {
//        NotificationCenter.default.post(name: NSNotification.Name(NotificationID.CHANGE_TO_QUEUE), object:nil, userInfo: ["data":""])
//    }
//      var videos =  [Video]()
//      var currentPosition = 0
//      var isShuffle = false
//      var isRepeat = false
//    
//    // singleton
//       private static var sharedDefault: QueuItemYoutube = {
//           let object = QueuItemYoutube()
//           return object
//       }()
//    class func shared() -> QueuItemYoutube {
//          return sharedDefault
//      }
//    func getCurrentVideo() -> Video  {
//           if videos.count == 0 {
//              return Video(id: 0, name: "", img_thumb: "", song_url: "", img_banner: "")
//           }
//           return videos[currentPosition]
//    }
//    
//    func addNewVideo(items : [Video]) {
//           self.videos.removeAll()
//           self.videos.append(contentsOf: items)
//           currentPosition = 0
//           self.notificationForUpdate()
//       }
//    func addNewQueueVideo(items: [Video], position: Int)  {
//              self.videos.removeAll()
//        
//        
//              self.videos.append(contentsOf: items)
//              currentPosition = position
//              self.notificationForUpdate()
//        }
//    
//    
//    func getQueuesVideo() -> [Video] {
//        return self.videos
//    }
//    
//    func addItemToQueueVideo(item: Video)  {
//        self.videos.append(item)
//        self.notificationForUpdate()
//    }
//    
//    func nextItem() {
//           if (isShuffle) {
//               setPosCurrentVideoRandom();
//           } else {
//               if (!isRepeat) {
//                   if videos.count == 1{
//                    currentPosition = 0
//                   }else if (currentPosition < videos.count - 1) {
//                       currentPosition += 1
//                   } else {
//                       currentPosition = 0
//                   }
//               }
//           }
//       }
//    
//    func setPosCurrentVideoRandom()  {
//           currentPosition = Int(arc4random_uniform(UInt32(videos.count)));
//    }
//    func prevItems() {
//           if (isShuffle) {
//               setPosCurrentVideoRandom();
//           } else {
//               if (!isRepeat) {
//                   if videos.count == 1{
//                       currentPosition = 0
//                   }else if (currentPosition > 0) {
//                       currentPosition -= 1
//                   } else {
//                       currentPosition = videos.count - 1
//                   }
//               }
//           }
//       }
//    
//    func remove(item: Video)  {
//           let size = videos.count
//           for i in 0..<size {
//               let video = videos[i]
//               if video.id == item.id{
//                   videos.remove(at: i)
//                   break
//               }
//           }
//           
//           notificationForUpdate()
//       }
//       
//    
//    
//    
//}
