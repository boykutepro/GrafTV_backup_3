//
//  QueuItemManager.swift
//  project
//
//  Created by tranthanh on 4/22/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit

class QueuItemManager {
    
    var items = [Song] ()
    
  
    var currentPosition = 0
    var isShuffle = false
    var isRepeat = false
    
    // singleton
    private static var sharedDefault: QueuItemManager = {
        let object = QueuItemManager()
        return object
    }()
    
    class func shared() -> QueuItemManager {
        return sharedDefault
    }

   
    
    func getCurrentItem() -> Song  {
        if items.count == 0 {
            return Song(title: "", artist: "", image: "", url: "", type: "")
        }
        return items[currentPosition]
    }
    
    
   
    
    func addNewQueue(item: Song)  {
        self.items.removeAll()
        self.items.append(item)
        currentPosition = 0
        self.notificationForUpdate()
    }
    
   
    func addNewQueue(items: [Song])  {
        self.items.removeAll()
        self.items.append(contentsOf: items)
        currentPosition = 0
        self.notificationForUpdate()
    }
    
    
   
    
    func addNewQueue(items: [Song], position: Int)  {
        self.items.removeAll()
        self.items.append(contentsOf: items)
        currentPosition = position
        self.notificationForUpdate()
    }
    
   
    
    func getQueues() -> [Song] {
        return self.items
    }
    
  
    func addItemToQueue(item: Song)  {
        self.items.append(item)
        self.notificationForUpdate()
    }
    
   
    
    func nextItem() {
        if (isShuffle) {
            setPosCurrentSongRandom();
        } else {
            if (!isRepeat) {
                if items.count == 1{
                 currentPosition = 0
                }else if (currentPosition < items.count - 1) {
                    currentPosition += 1
                } else {
                    currentPosition = 0
                }
            }
        }
    }
    
    func setPosCurrentSongRandom()  {
        currentPosition = Int(arc4random_uniform(UInt32(items.count)));
    }
    
    func prevItems() {
        if (isShuffle) {
            setPosCurrentSongRandom();
        } else {
            if (!isRepeat) {
                if items.count == 1{
                    currentPosition = 0
                }else if (currentPosition > 0) {
                    currentPosition -= 1
                } else {
                    currentPosition = items.count - 1
                }
            }
        }
    }
    
    
    func remove(item: Song)  {
        let size = items.count
        for i in 0..<size {
            let song = items[i]
            if song.id == item.id{
                items.remove(at: i)
                break
            }
        }
        
        notificationForUpdate()
    }
    
    
    
    func notificationForUpdate()  {
        NotificationCenter.default.post(name: NSNotification.Name(NotificationID.CHANGE_TO_QUEUE), object:nil, userInfo: ["data":""])
    }
}
