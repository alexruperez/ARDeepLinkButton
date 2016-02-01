//
//  ARDeepLinkHandler.swift
//  ARDeepLinkButton
//
//  Created by alexruperez on 31/1/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import UIKit
import StoreKit

// MARK: - ARDeepLinkHandler

public class ARDeepLinkHandler: NSObject, SKStoreProductViewControllerDelegate {
    
    // MARK: - Properties
    
    /// Current SKStoreProductViewController.
    public var storeProductViewController: SKStoreProductViewController?
    
    /// Current UIApplication.
    private var application: UIApplication {
        return UIApplication.sharedApplication()
    }
    
    /// Current presented UIViewController.
    private var presentedViewController: UIViewController? {
        var viewController = self.application.keyWindow?.rootViewController
        while (viewController?.presentedViewController != nil) {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
    
    // MARK: - Public methods
    
    /**
    Open the deepLink if can, else present SKStoreProductViewController configured with passed appStoreId if can, else opens passed iTunesURLString if can.
    
    - parameter deepLink:           DeepLink to be opened.
    - parameter appStoreId:         AppStoreID to configure SKStoreProductViewController.
    - parameter iTunesURLString:    URL to be opened if SKStoreProductViewController fails.
    
    - returns: The open result.
    */
    public func handle(deepLink: String?, appStoreId: String?, iTunesURLString: String?) -> Bool {
        return self.handle(deepLink) || self.handle(appStoreId, iTunesURLString: iTunesURLString) || self.handle(iTunesURLString)
    }
    
    /**
     Present SKStoreProductViewController configured with passed appStoreId if can, else opens passed iTunesURLString if can.
     
     - parameter appStoreId:        AppStoreID to configure SKStoreProductViewController.
     - parameter iTunesURLString:   URL to be opened if SKStoreProductViewController fails.
     
     - returns: The open result.
     */
    public func handle(appStoreId: String?, iTunesURLString: String?) -> Bool {
        if let appStoreId = appStoreId {
            if let appStoreIdUIntValue = UInt(appStoreId) {
                self.storeProductViewController = SKStoreProductViewController()
                self.storeProductViewController!.delegate = self
                self.storeProductViewController!.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier: NSNumber(unsignedInteger: appStoreIdUIntValue)], completionBlock: { (result: Bool, error: NSError?) -> Void in
                    if result == false || error != nil {
                        self.handle(iTunesURLString)
                    }
                    self.storeProductViewController = nil
                })
                self.presentedViewController?.presentViewController(self.storeProductViewController!, animated: true, completion: nil)
                return true
            }
        }
        return false
    }
    
    /**
     Opens passed URLString if can.
     
     - parameter URLString:     URL to be opened.
     
     - returns: The open result.
     */
    public func handle(URLString: String?) -> Bool {
        if let URLString = URLString {
            if let URL = NSURL(string: URLString) {
                if self.application.canOpenURL(URL) {
                    return self.application.openURL(URL)
                }
            }
        }
        return false
    }
    
    // MARK: - SKStoreProductViewControllerDelegate
    
    public func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }

}
