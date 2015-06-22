//
//  URLHandlerTests.swift
//  exitpath
//
//  Created by Nicholas Maccharoli on 6/22/15.
//  Copyright (c) 2015 Nicholas Maccharoli. All rights reserved.
//

import XCTest

class URLHandlerTests: XCTestCase {

    var linkDispatch : LinkDispatch!
    var baseUrl : String?
    var testUrl : String?

    override func setUp() {
        super.setUp()
        baseUrl = "http://www.example.com"
        testUrl = "http://www.example.com/users/"
        linkDispatch = LinkDispatch(baseUrl: baseUrl!)

    }

    func testLinkHandlingGettingCalled(){

        var blockCalled = false
        linkDispatch.handleUrlWithPath("profiles", handler: {$0 })
        linkDispatch.handleUrlWithPath("users", handler: { element in blockCalled = true})
        linkDispatch.urlClicked(testUrl!)
        XCTAssert(blockCalled == true, "Not properly dispatching links.")
    }

}