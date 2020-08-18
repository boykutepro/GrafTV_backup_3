//
//  UITextView.swift
//  NewReader
//
//  Created by tranthanh on 3/24/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//


import UIKit

// MARK: - Methods
public extension UITextView {

    /// SwifterSwift: Clear text.
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    /// SwifterSwift: Scroll to the bottom of text view
    func scrollToBottom() {
        // swiftlint:disable:next legacy_constructor
        let range = NSMakeRange((text as NSString).length - 1, 1)
        scrollRangeToVisible(range)
    }

    /// SwifterSwift: Scroll to the top of text view
    func scrollToTop() {
        // swiftlint:disable:next legacy_constructor
        let range = NSMakeRange(0, 1)
        scrollRangeToVisible(range)
    }

    /// SwifterSwift: Wrap to the content (Text / Attributed Text).
    func wrapToContent() {
        contentInset = .zero
        scrollIndicatorInsets = .zero
        contentOffset = .zero
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        sizeToFit()
    }

}
