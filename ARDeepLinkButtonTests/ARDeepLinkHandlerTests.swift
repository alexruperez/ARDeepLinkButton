//
//  ARDeepLinkHandlerTests.swift
//  ARDeepLinkButton
//
//  Created by alexruperez on 31/1/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import XCTest
@testable import ARDeepLinkButton

class ARDeepLinkHandlerTests: XCTestCase {
    
    var deepLinkHandler: ARDeepLinkHandler?
    
    override func setUp() {
        super.setUp()
        
        self.deepLinkHandler = ARDeepLinkHandler()
    }
    
    override func tearDown() {
        self.deepLinkHandler = nil
        
        super.tearDown()
    }
    
    func testStoreProductViewController() {
        self.deepLinkHandler?.handle(nil, appStoreId: "1067596651", iTunesURLString: nil)
        XCTAssert(self.deepLinkHandler?.storeProductViewController != nil, "storeProductViewController doesn't exist")
    }
    
}
