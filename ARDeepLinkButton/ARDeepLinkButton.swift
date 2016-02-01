//
//  ARDeepLinkButton.swift
//  ARDeepLinkButton
//
//  Created by alexruperez on 31/1/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import UIKit

// MARK: - ARDeepLinkButton

/**
UIButton subclass that handle deep links, shows in-app SKStoreProductViewController or redirects to the AppStore.
*/
@IBDesignable
public class ARDeepLinkButton: UIButton {
    
    // MARK: - Properties
    
    /// Example: "madbike://".
    @IBInspectable public var deepLink: String?
    
    /// Example: "https://itunes.apple.com/us/app/madbike/id1067596651?mt=8".
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
    
    /// Corner radius.
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    /// Border width.
    @IBInspectable public var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /// Border color.
    @IBInspectable public var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.CGColor
        }
        get {
            return layer.borderColor != nil ? UIColor(CGColor: layer.borderColor!) : nil
        }
    }
    
    /// Image UIViewContentMode value. Example: 1 for .ScaleAspectFit.
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
    
    /// Image corner radius.
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
    
    /**
     Deep link handler, here you have access to SKStoreProductViewController in order to customize it.
     */
    public lazy var deepLinkHandler = ARDeepLinkHandler()
    
    /// Automatically generated when iTunesURL is setted.
    public private(set) var appStoreId: String?
    
    // MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: "touchUpInsideAction:", forControlEvents: .TouchUpInside)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: "touchUpInsideAction:", forControlEvents: .TouchUpInside)
    }
    
    /**
     Initializes and returns a newly allocated ARDeepLinkButton with the specified deepLink and iTunesURL.
     
     - parameter deepLink:      Example: "madbike://".
     - parameter iTunesURL:     Example: "https://itunes.apple.com/us/app/madbike/id1067596651?mt=8".
     
     - returns: An initialized ARDeepLinkButton or nil if the object couldn't be created.
     */
    convenience public init(deepLink: String?, iTunesURL: String?) {
        self.init(frame: CGRectZero)
        self.initialize(deepLink, iTunesURL: iTunesURL)
    }
    
    // MARK: - Private methods
    
    /**
     Configures the ARDeepLinkButton with the specified deepLink and iTunesURL.
     
     - parameter deepLink:      Example: "madbike://".
     - parameter iTunesURL:     Example: "https://itunes.apple.com/us/app/madbike/id1067596651?mt=8".
     */
    private func initialize(deepLink: String?, iTunesURL: String?) {
        self.deepLink = deepLink
        self.iTunesURL = iTunesURL
    }
    
    // MARK: - @IBActions
    
    /**
     Handles the ARDeepLinkButton .TouchUpInside @IBAction.
     
     - parameter sender:        @IBAction sender.
     */
    @IBAction public func touchUpInsideAction(sender: UIButton) {
        self.deepLinkHandler.handle(self.deepLink, appStoreId: self.appStoreId, iTunesURLString: self.iTunesURL)
    }

}
