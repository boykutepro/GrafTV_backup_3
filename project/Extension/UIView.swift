//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
    
    func roundedView() {
           self.layer.cornerRadius = self.frame.size.width / 2
           self.clipsToBounds = true
    }
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    
    
    
}

extension UIView {
    
    
    func setGradientBackgroundView(colorTop: UIColor, colorBottom: UIColor){
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        
          gradientLayer.startPoint = CGPoint(x: 0, y: 1)
          gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.locations = [0, 1]
            gradientLayer.frame = bounds

            layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.cornerRadius = 16
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        //layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

}






extension UITextField {
    
    func changePlacehoderColor(_ color: UIColor) {
        //self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
        let placeholderString = NSAttributedString.init(string: "", attributes: [NSAttributedString.Key.foregroundColor : color])
        self.attributedPlaceholder = placeholderString
        
    }
    
    func changePlacehoderColor(_ color: UIColor, placeholder: String) {
        //self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
        let placeholderString = NSAttributedString.init(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        self.attributedPlaceholder = placeholderString
        
    }
    
    
}





public enum BorderSide {
    case top, bottom, left, right
}

extension UIView {
    public func addBorder(side: BorderSide, color: UIColor, width: CGFloat) {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = color
        self.addSubview(border)

        let topConstraint = topAnchor.constraint(equalTo: border.topAnchor)
        let rightConstraint = trailingAnchor.constraint(equalTo: border.trailingAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: border.bottomAnchor)
        let leftConstraint = leadingAnchor.constraint(equalTo: border.leadingAnchor)
        let heightConstraint = border.heightAnchor.constraint(equalToConstant: width)
        let widthConstraint = border.widthAnchor.constraint(equalToConstant: width)


        switch side {
        case .top:
            NSLayoutConstraint.activate([leftConstraint, topConstraint, rightConstraint, heightConstraint])
        case .right:
            NSLayoutConstraint.activate([topConstraint, rightConstraint, bottomConstraint, widthConstraint])
        case .bottom:
            NSLayoutConstraint.activate([rightConstraint, bottomConstraint, leftConstraint, heightConstraint])
        case .left:
            NSLayoutConstraint.activate([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
        }
    }
}
