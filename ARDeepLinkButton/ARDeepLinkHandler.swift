//
//  ARDeepLinkHandler.swift
//  ARDeepLinkButton
//
//  Created by alexruperez on 31/1/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import UIKit
import StoreKit

public class ARDeepLinkHandler: NSObject, SKStoreProductViewControllerDelegate {
    
    public var storeProductViewController: SKStoreProductViewController?
    
    private var application: UIApplication {
        return UIApplication.sharedApplication()
    }
    
    private var presentedViewController: UIViewController? {
        var viewController = self.application.keyWindow?.rootViewController
        while (viewController?.presentedViewController != nil) {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
    
    public func handle(deepLink: String?, appStoreId: String?, iTunesURLString: String?) -> Bool {
        return self.handle(deepLink) || self.handle(appStoreId, iTunesURLString: iTunesURLString) || self.handle(iTunesURLString)
    }
    
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
    
    public func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }

}
