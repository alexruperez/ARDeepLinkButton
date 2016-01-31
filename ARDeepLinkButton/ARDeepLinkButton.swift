//
//  ARDeepLinkButton.swift
//  ARDeepLinkButton
//
//  Created by alexruperez on 31/1/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import UIKit

@IBDesignable
public class ARDeepLinkButton: UIButton {
    
    @IBInspectable public var deepLink: String?
    
    @IBInspectable public var iTunesURL: String? {
        didSet {
            if let iTunesURL = self.iTunesURL {
                do {
                    let regex = try NSRegularExpression(pattern: "(\\d+)", options: [])
                    let range = regex.rangeOfFirstMatchInString(iTunesURL, options: [], range: NSMakeRange(0, iTunesURL.characters.count))
                    let iTunesURLString: NSString = iTunesURL
                    self.appStoreId = iTunesURLString.substringWithRange(range)
                } catch let error as NSError {
                    print("\(error.localizedDescription)")
                    self.appStoreId = nil
                }
            }
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.CGColor
        }
        get {
            return layer.borderColor != nil ? UIColor(CGColor: layer.borderColor!) : nil
        }
    }
    
    @IBInspectable public var imageContentMode: Int {
        set {
            if let imageView = imageView {
                if let contentMode = UIViewContentMode(rawValue: newValue) {
                    contentVerticalAlignment = .Fill
                    contentHorizontalAlignment = .Fill
                    imageView.contentMode = contentMode
                }
            }
        }
        get {
            return imageView != nil ? imageView!.contentMode.rawValue : UIViewContentMode.ScaleToFill.rawValue
        }
    }
    
    @IBInspectable public var imageCornerRadius: CGFloat {
        set {
            if let imageView = imageView {
                imageView.layer.cornerRadius = newValue
            }
        }
        get {
            return imageView != nil ? imageView!.layer.cornerRadius : 0
        }
    }
    
    public lazy var deepLinkHandler = ARDeepLinkHandler()
    
    public private(set) var appStoreId: String?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: "touchUpInsideAction:", forControlEvents: .TouchUpInside)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: "touchUpInsideAction:", forControlEvents: .TouchUpInside)
    }
    
    convenience public init(deepLink: String?, iTunesURL: String?) {
        self.init(frame: CGRectZero)
        self.initialize(deepLink, iTunesURL: iTunesURL)
    }
    
    private func initialize(deepLink: String?, iTunesURL: String?) {
        self.deepLink = deepLink
        self.iTunesURL = iTunesURL
    }
    
    @IBAction public func touchUpInsideAction(sender: UIButton) {
        self.deepLinkHandler.handle(self.deepLink, appStoreId: self.appStoreId, iTunesURLString: self.iTunesURL)
    }

}
