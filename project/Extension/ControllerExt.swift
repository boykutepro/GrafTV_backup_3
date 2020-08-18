//
//  ControllerExt.swift
//  project
//
//  Created by Trang Pham on 12/3/18.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func initWithNibName() -> Self {
        return self.init(nibName: "\(self)", bundle: nil)
    }
}

extension UIViewController {
    
    func reloadViewFromNib() {
           let parent = view.superview
           view.removeFromSuperview()
           view = nil
           parent?.addSubview(view) // This line causes the view to be reloaded
       }
    //MARK: -ForStatusAlert
   
    func showToast(message : String) {
          let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 200, height: 35))
          toastLabel.backgroundColor = #colorLiteral(red: 0.9606800675, green: 0.9608443379, blue: 0.9606696963, alpha: 1)
          toastLabel.textColor = #colorLiteral(red: 0.290160656, green: 0.2902164459, blue: 0.2901571095, alpha: 1)
          toastLabel.textAlignment = .center;
          toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
          toastLabel.text = message
          toastLabel.alpha = 1.0
          toastLabel.layer.cornerRadius = 10;
          toastLabel.clipsToBounds  =  true
          self.view.addSubview(toastLabel)
          UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
              toastLabel.alpha = 0.0
          }, completion: {(isCompleted) in
              toastLabel.removeFromSuperview()
          })
      }
    func showToastWindown(message : String) {
            
           guard let window = UIWindow.key else {return}
           let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
           toastLabel.backgroundColor =  #colorLiteral(red: 0.9606800675, green: 0.9608443379, blue: 0.9606696963, alpha: 1)
           toastLabel.textColor = #colorLiteral(red: 0.290160656, green: 0.2902164459, blue: 0.2901571095, alpha: 1)
           toastLabel.textAlignment = .center;
           toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
           toastLabel.text = message
           toastLabel.alpha = 1.0
           toastLabel.layer.cornerRadius = 10;
           toastLabel.clipsToBounds  =  true
           self.view.addSubview(toastLabel)
           window.addSubview(toastLabel)
           UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
               toastLabel.alpha = 0.0
           }, completion: {(isCompleted) in
               toastLabel.removeFromSuperview()
           })
       }
    
     //MARK: -add and remove the child of controller
    func add(asChildViewController viewController: UIViewController) {
        
            // Add Child View Controller
            addChild(viewController)
            // Add Child View as Subview
            view.addSubview(viewController.view)
            // Configure Child View
            viewController.view.frame = view.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            // Notify Child View Controller
            viewController.didMove(toParent: self)
    }
    func remove(asChildViewController viewController: UIViewController) {
            // Notify Child View Controller
            viewController.willMove(toParent: nil)
            // Remove Child View From Superview
            viewController.view.removeFromSuperview()
            // Notify Child View Controller
            viewController.removeFromParent()
        }
          
    
    //MARK:  -Custom Alert
    private func createAttribute(message: String) -> NSAttributedString {
           // Create AttributeString
           let customMessage = message
           let attributes:[String : AnyObject] = [
               convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "Helvetica Neue", size: 13)!]
           let attributeMessage = NSAttributedString(string: customMessage as String, attributes: convertToOptionalNSAttributedStringKeyDictionary(attributes))
           return attributeMessage
       }
    
      func showAlert(title: String?, message: String,
                     btnLeft: String?, actionLeft: (() -> ())?,
                     btnRight: String?, actionRight: (() -> ())? ) {
          
          let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
          // Check title left is availabel
          if let titleLeft = btnLeft {
              let leftAction = UIAlertAction(title: titleLeft, style: .default) { (_) in
                  // Check action left is availabel
                  if actionLeft != nil {
                      actionLeft!()
                  }
                  
              }
              // Add action
              alert.addAction(leftAction)
          }
          // Check title right is availabel
          if let titleRight = btnRight {
              let rightAction = UIAlertAction(title: titleRight, style: .default) { (_) in
                  // Check action right is availabel
                  if actionRight != nil {
                      actionRight!()
                  }
              }
              // Add action
              alert.addAction(rightAction)
          }
          
          // Set attribute string for message of UIAlertcontroller
          alert.setValue(createAttribute(message: message), forKey: "attributedMessage")
          // Show alert
          self.present(alert, animated: true, completion: nil)
      }
      func showAlertNormal(title: String, message: String) {
          self.showAlert(title: title, message: message,
                         btnLeft: nil, actionLeft: nil,
                         btnRight: "OK", actionRight: nil)
      }
      func showAlertInputText(title: String?, message: String?, placeHoder: String, keyboardType: UIKeyboardType, titleRight: String, actionRight: @escaping ((_ text: String) -> ())) {
          let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
          let cancelAction = UIAlertAction(title: "Cancel",
                                           style: .default,
                                           handler: nil)
          let rightAction = UIAlertAction(title: titleRight, style: .default) { (_) in
              let text = alert.textFields![0].text!
              actionRight(text)
          }
          alert.addAction(cancelAction)
          alert.addAction(rightAction)
          // Add textfield to alert controller
          alert.addTextField { (textfield) in
              // Configure textfield
              textfield.placeholder = placeHoder
              textfield.keyboardType = keyboardType
              textfield.clearButtonMode = .whileEditing
          }
          // Check message have value
          if message != nil {
              // Set attribute string for message of UIAlertcontroller
              alert.setValue(createAttribute(message: message!), forKey: "attributedMessage")
          }
          // Show alert
          self.present(alert, animated: true, completion: nil)
      }

    //MARK: -Show Action Sheet Select Photo
       func showSelectPhoto(photoPicker: UIImagePickerController, in viewController: UIViewController, sourceView: UIView) {
           // Create Action Open Camera
           let openCamera = UIAlertAction(title: "Take Photo by Camera",
                                          style: .default,
                                          handler: { (_) in
                                           if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                               photoPicker.sourceType = .camera
                                               viewController.present(photoPicker, animated: true, completion: nil)
                                           } else {
                                               self.showAlertNormal(title: "ERROR", message: "Not found camera !")
                                           }
           })
           // Create Action Open Photo Library
           let openPhotoLibrary = UIAlertAction(title: "Add from Gallery",
                                                style: .default,
                                                handler: { (_) in
                                                   photoPicker.sourceType = .photoLibrary
                                                   viewController.present(photoPicker, animated: true, completion: nil)
           })
           // Create Action Cancel
           let cancel = UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil)
           // Create ActionSheet
           let actionSheet = UIAlertController(title: "Add Photo",
                                               message: nil,
                                               preferredStyle: .actionSheet)
           // Add Actions
           actionSheet.addAction(openPhotoLibrary)
           actionSheet.addAction(openCamera)
           actionSheet.addAction(cancel)
           // Configure ActionSheet for iPad
           actionSheet.modalPresentationStyle = .popover
           if let presenter = actionSheet.popoverPresentationController {
               presenter.sourceView = sourceView
               presenter.sourceRect = sourceView.frame
           }
           // Show ActionSheet
           viewController.present(actionSheet, animated: true, completion: nil)
       }
       
       //MARK: for keyboard
       func hideKeyBoardTapScreen() {
           self.view.endEditing(true)
       }
    
}
// Helper function inserted by Swift 4.2 migrator.
func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
 func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
    /// Return an UINib object from the nib file with the same name.
     class var nib: UINib? {
       return UINib(nibName: String(describing: self), bundle: nil)
     }
     class var viewFromNib: UIView? {
       let views = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)
       let view = views![0] as! UIView
       return view
     }
}
