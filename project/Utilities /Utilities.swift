//
//  Utilities.swift
//  
//
//  Created by SUUSOFT on 5/18/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit
//import KeychainSwift
//import SkyFloatingLabelTextField
import MessageUI

class Utilities {
    
    // Avoid init
    private init() {
        
    }
    
    // MARK: - Background gradient
    class func setBackgroundGradient( view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: - Image Button
    class func setImageButton( button: UIButton, image : String ) {
        button.setImage(UIImage(named: image)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    // MARK: - Image
    class func setImage( img: UIImageView, image : String ) {
        img.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
    }
    
    // MARK: - For text
    class func createTextColor(for views: UILabel..., color: UIColor) {
        // create border for many views or a view
        for view in views {
            view.textColor = color
        }
    }
    class func createTintColorButton(for views: UIButton..., color: UIColor) {
           // create border for many views or a view
           for view in views {
               view.tintColor = color
           }
       }
       
    class func createTextColorButton(for views: UIButton..., color: UIColor) {
        // create border for many views or a view
        for view in views {
            view.setTitleColor(color, for: .normal)
        }
    }
    class func createTextFieldPlaceholderColor(for views: UITextField..., color: UIColor) {
        // create border for many views or a view
        for view in views {
            view.placeholderColor(color: color)
        }
    }
    
    class func createTextFieldColor(for views: UITextField..., color: UIColor) {
        // create border for many views or a view
        for view in views {
            
            view.textColor = color
            
        }
    }
    
    // MARK: - for Views
    class func createColorView(for views: UIView...,color : UIColor) {
        // create border for many views or a view
        for view in views {
            view.backgroundColor  = color
        }
    }
    
    class func createGradientBackground(for views: UIView...,colorTop : UIColor , colorBottom : UIColor) {
        // create border for many views or a view
        for view in views {
            view.setGradientBackgroundView(colorTop: colorTop, colorBottom: colorBottom)
        }
    }
    
    // MARK: - Create Border , CornerRadius & Shadow for Views
    class func createBorder(for views: UIView..., color: UIColor, width: CGFloat) {
        // create border for many views or a view
        for view in views {
            view.layer.borderWidth = width
            view.layer.borderColor = color.cgColor
        }
    }
    
    class func createCornerRadius(for views: UIView..., radius: CGFloat) {
        // create border for many views or a view
        for view in views {
            view.layer.cornerRadius = radius
        }
    }
    
    
    class func createCornerImage(for views: UIImageView..., radius: CGFloat) {
        // create border for many views or a view
        for view in views {
            view.layer.cornerRadius = radius
            view.clipsToBounds = true
            
        }
    }
    
    class func createShadow(for views: UIView...,
        opacity: Float = 0.5,
        radius: CGFloat = 5.0,
        offSet: CGSize = CGSize.zero,
        cgColor: CGColor = UIColor.black.cgColor) {
        // Create shadow for many views or a view
        for view in views {
            view.layer.shadowColor = cgColor
            view.layer.shadowRadius = radius
            view.layer.shadowOffset = offSet
            view.layer.shadowOpacity = opacity
        }
    }
    
    
    
    //MARK: - Animation
    class func animate(duration: TimeInterval , damping: CGFloat, velocity: CGFloat, fromValue: () -> Void, toValue: @escaping () -> Void) {
        // Set begin value animation
        fromValue()
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: .allowUserInteraction,
                       animations: {
                        // Set end value animation
                        toValue()
        },
                       completion: nil)
    }
    
    class func animateCompletion(duration: TimeInterval , damping: CGFloat, velocity: CGFloat, animation: @escaping () -> Void, completion: (() -> ())?) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: .allowUserInteraction,
                       animations: {
                        // Handle animation
                        animation()
        }, completion: { (_) in
            // Check completion is availabel
            if completion != nil {
                completion!()
            }
        })
    }
    
    
    
    //MARK: - Validate Value
    func getIntValue(object: AnyObject?, errorValue: Int, didError: (()-> Void)? = nil) -> Int {
        if object == nil || object is NSNull {
            return errorValue
        }
        
        if object is String {
            if let int = Int(object as! String) {
                return int
            }
        }
        
        if object is NSNumber {
            return object as! Int
        }
        
        if object is Int {
            return object as! Int
        }
        
        didError?()
        return errorValue
    }
    
    class func openUrl(urlString: String) {
        if let url = URL(string: urlString) {
            if #available(iOS 10, *) { // For ios 10 and greater
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(urlString): \(success)")
                })
            } else { // for below ios 10.
                let success = UIApplication.shared.openURL(url)
                print("Open \(urlString): \(success)")
            }
        }
    }
    
    
    class func validateEmail(_ email:String) -> Bool {
        let emailRegEx = "^[a-zA-Z]+(([\\'\\,\\.\\- ][a-zA-Z ])?[a-zA-Z]*)*\\s+&lt;(\\w[-._\\w]*\\w@\\w[-._\\w]*\\w\\.\\w{2,6})&gt;$|^(\\w[-._\\w]*\\w@\\w[-._\\w]*\\w\\.\\w{2,6})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isEmail = emailTest.evaluate(with: email)
        // Validate email
        if !validateInfomation(email, minCharacter: 6, maxCharacter: 50) ||
            !isEmail {
            return false
        } else {
            return true
        }
    }
    
    
    
    
    
    class func validateInfomation(_ text: String, minCharacter: Int = 2, maxCharacter: Int = 50) -> Bool {
        if text.trimmingCharacters(in: .whitespaces).isEmpty ||
            text.trimmingCharacters(in: .whitespaces).count < minCharacter ||
            text.trimmingCharacters(in: .whitespaces).count > maxCharacter {
            return false
        } else {
            return true
        }
    }
    
    class func setTextHtml(_ tv : UITextField,_ text : String){
        let htmlData = NSString(string: text ).data(using: String.Encoding.utf8.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!,options: options,documentAttributes: nil)
        
        tv.attributedText = attributedString
        
    }
    
    class func openLink(_ link : String){
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    class func sendEmail(vc : UIViewController, email : String ) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            //mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            //mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            vc.present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    
    
    class func mailTo( email : String ) {
        let url = NSURL(string: "mailto:\(email)")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url! as URL)
        }
    }
    
}

