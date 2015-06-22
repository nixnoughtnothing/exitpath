//
//  URLHelpersTests.swift
//  exitpath
//
//  Created by Nicholas Maccharoli on 6/22/15.
//  Copyright (c) 2015 Nicholas Maccharoli. All rights reserved.
//

import XCTest

class URLHelpersTests : XCTestCase {

    var testUrl : String!
    var baseUrl : String!

    override func setUp() {
        super.setUp()
        testUrl = "http://www.testcase.com/part1/part2/?para1=red&para2=green&para3=blue"
        baseUrl = "http://www.testcase.com"
    }

    func testCanDetectParameters(){
        let getParams = extractGetParamenters(testUrl)
        XCTAssert(getParams.keys.array.count == 3, "Not Properly Extracting Get Parameters.")
    }

    func testCanExtractPathFromURL(){
        let path = extractUrlPath(testUrl, baseUrl)
        XCTAssert(path.count == 2, "Properly Extracting Path.")
    }

    func testCanExtractPathFromURLHasProperPath(){
        let path = extractUrlPath(testUrl, baseUrl)
        XCTAssert(path[0] == "part1", "Properly Extracting Path Component.")
    }

    func testUrlSanitationFull(){
        let sanitizedUrl = sanitizeUrl(baseUrl)
        XCTAssert(sanitizedUrl == "testcase.com")
    }

    func testUrlSanitationPartial(){
        let sanitizedUrl = sanitizeUrl("www.testcase.com")
        XCTAssert(sanitizedUrl == "testcase.com")
    }

    func testUrlSanitationAlreadyClean(){
        let sanitizedUrl = sanitizeUrl("testcase.com")
        XCTAssert(sanitizedUrl == "testcase.com")
    }

    func testGrabbingSubdomain(){
        let subdomain = extractSubDomain("http://www.items.example.com", "http://www.example.com")
        XCTAssert(subdomain == "items", "Not properly extracting subdomain.")
    }
}