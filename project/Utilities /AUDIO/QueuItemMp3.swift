//
//  QueuItemMp3.swift
//  project
//
//  Created by tranthanh on 5/12/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit
import MediaPlayer


//class QueuItemMp3 {
//    
//    var items = [SongItem]()
//    var isShuffle = false
//    var isRepeat = false
//  
//    var currentPosition = 0
//    
//    
//    func getCurrentItem() -> SongItem {
//        if items.count == 0 {
//            return SongItem(id: "", songPath: "", artistName: "", songName: "")
//        }
//        return items[currentPosition]
//    }
//    
//    func getQueues() -> [SongItem] {
//        return self.items
//    }
//    
//    func addItemToQueue(item: SongItem)  {
//        self.items.append(item)
//        self.notificationForUpdate()
//    }
//    
//    func addNewQueue(items: [SongItem])  {
//        self.items.removeAll()
//        self.items.append(contentsOf: items)
//        currentPosition = 0
//        self.notificationForUpdate()
//    }
//    
//    func addNewQueue(items: [SongItem], position: Int)  {
//        self.items.removeAll()
//        self.items.append(contentsOf: items)
//        currentPosition = position
//        self.notificationForUpdate()
//    }
//    
//    // singleton
//    private static var sharedDefault: QueuItemMp3  = {
//        let object = QueuItemMp3()
//        return object
//    }()
//    
//    class func shared() -> QueuItemMp3 {
//        return sharedDefault
//    }
//
//
//    func nextItem() {
//        if (isShuffle) {
//            setPosCurrentSongRandom();
//        } else {
//            if (!isRepeat) {
//                if items.count == 1{
//                 currentPosition = 0
//                }else if (currentPosition < items.count - 1) {
//                    currentPosition += 1
//                } else {
//                    currentPosition = 0
//                }
//            }
//        }
//    }
//    
//    func setPosCurrentSongRandom()  {
//        currentPosition = Int(arc4random_uniform(UInt32(items.count)));
//    }
//    
//    func prevItems() {
//        if (isShuffle) {
//            setPosCurrentSongRandom();
//        } else {
//            if (!isRepeat) {
//                if items.count == 1{
//                    currentPosition = 0
//                }else if (currentPosition > 0) {
//                    currentPosition -= 1
//                } else {
//                    currentPosition = items.count - 1
//                }
//            }
//        }
//    }
//    
//    
//    func remove(item: SongItem)  {
//        let size = items.count
//        for i in 0..<size {
//            let song = items[i]
//            if song.id == item.id{
//                items.remove(at: i)
//                break
//            }
//        }
//        
//        notificationForUpdate()
//    }
//    
//    
//    
//    func notificationForUpdate()  {
//        NotificationCenter.default.post(name: NSNotification.Name(NotificationID.CHANGE_TO_QUEUE), object:nil, userInfo: ["data":""])
//    }
//}
