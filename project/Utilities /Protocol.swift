//
//  Protocol.swift
//  project
//
//  Created by tranthanh on 4/17/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import UIKit


protocol OnClickItemPlaylist {
//    func onClickMore(item : PlaylistTitle)
    func onClickItem(item : Video)
}


protocol ItemVideoDelegate {
    func onShowActionMenu(actionMenu: UIAlertController)
    func onItemClicked(index: Int)
    func onItemDeleted(index: Int)
    func onItemAddToQueue(index: Int)
}
