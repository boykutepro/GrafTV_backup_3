//
//  DowloadMannager.swift
//  project
//
//  Created by tranthanh on 5/7/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import Foundation
import Alamofire

protocol DownloadFinishedDelegate {
    func downloadSuccess()
    func downloadError()
}

class DownloadManager {
    
    var delegate: DownloadFinishedDelegate?
    
    class func share() -> DownloadManager{
        return DownloadManager()
    }
    
    public func setDelegate(delegate: DownloadFinishedDelegate) -> DownloadManager{
        self.delegate = delegate
        return self
    }
    
    func downloadUrl(item: Song)  {
      
        let attachment = item.file
        let arrAttachment = attachment.components(separatedBy: "/")
        let nameLocalFile = arrAttachment[arrAttachment.count - 1]
        var urlFinal: String = ""
        let destination1: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let fileURL = documentsURL.appendingPathComponent(nameLocalFile)
            urlFinal = fileURL.absoluteString
            print("destination2: \(fileURL.absoluteURL)")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let request = Alamofire.download(item.getUrl()!, to: destination1).downloadProgress(closure: { (progress) in
            var progressNow = round(progress.fractionCompleted * 100)
            print("\(progressNow) %")
            
        }).responseData
            { response in
                if response.result.isFailure {
                    print("\(response.error!)")
                    self.delegate!.downloadError()
                    
                } else {
                    print("Download successfully!")
                    item.file = nameLocalFile
                    item.type = "2" // 2 is downloaded file
                    DOWNLOADED_SONG.append(item)
                    self.delegate!.downloadSuccess()
                    self.saveArtist(song: item)
                    
                }
        }
    }
    
    func saveArtist(song: Song)  {
        let artistList = song.artists
        for item in artistList {
            if !ARTISTS.contains(where: { $0.title == item.title }) {
                item.updateDownloadedSong()
               ARTISTS.append(item)
            }
        }
        
        
    }
}

