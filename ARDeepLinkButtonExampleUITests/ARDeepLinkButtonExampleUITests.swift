//
//  ARDeepLinkButtonExampleUITests.swift
//  ARDeepLinkButtonExampleUITests
//
//  Created by alexruperez on 31/1/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import XCTest

class ARDeepLinkButtonExampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeepLinkButtonTap() {
        XCUIApplication().buttons["MADBikeIcon"].tap()
    }
    
}
