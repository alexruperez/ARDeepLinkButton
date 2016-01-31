//
//  ARDeepLinkButtonTests.swift
//  ARDeepLinkButtonTests
//
//  Created by alexruperez on 31/1/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import XCTest
@testable import ARDeepLinkButton

class ARDeepLinkButtonTests: XCTestCase {
    
    var deepLinkButton: ARDeepLinkButton?
    
    override func setUp() {
        super.setUp()
        
        self.deepLinkButton = ARDeepLinkButton()
    }
    
    override func tearDown() {
        self.deepLinkButton = nil
        
        super.tearDown()
    }
    
    func testAppStoreId() {
        self.deepLinkButton?.iTunesURL = "https://itunes.apple.com/us/app/madbike/id1067596651?mt=8"
        XCTAssert(self.deepLinkButton?.appStoreId == "1067596651", "appStoreId generated incorrectly")
    }
    
}
