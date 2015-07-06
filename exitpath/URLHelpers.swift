//
//  URLHelpers.swift
//  exitpath
//
//  Created by Nicholas Maccharoli on 6/22/15.
//  Copyright (c) 2015 Nicholas Maccharoli. All rights reserved.
//

import Foundation

// MARK: - String Extension
extension String {
    var length: Int { return count(self)   }  // Swift 1.2
}

infix operator =~ {}

func =~ (input: String, pattern: String) -> Bool {
    return Regex(pattern).test(input)
}

// MARK: - Domain Processing
func extractGetParamenters(url : String) -> [String : String]{
    var getDict = [String : String]()
    var getParams = split(url){ $0 == "?" || $0 == "&"}
    getParams.removeAtIndex(0)
    for element in getParams {
        var components = split(element){ $0 == "="}
        getDict[components[0]] = components[1]
    }
    return getDict
}

func extractUrlPath(url : String, baseUrl : String) -> [String] {
    var urlPath = [String]()
    
    if !url.hasPrefix(baseUrl) {
        return []
    }
    
    var latterPart = url.substringFromIndex(baseUrl.endIndex)
    if let eraseFrom = latterPart.rangeOfString("?")?.startIndex {
        latterPart.removeRange(eraseFrom..<latterPart.endIndex)
    }
    return split(latterPart){ $0 == "/" }
}

func sanitizeUrl(var url : String) -> String{
    url = url.stringByReplacingOccurrencesOfString("https://", withString: "")
    url = url.stringByReplacingOccurrencesOfString("http://", withString: "")
    return url.stringByReplacingOccurrencesOfString("www.", withString: "")
}

func extractSubDomain(url : String, baseUrl : String) -> String {
    var sanitizedBase = sanitizeUrl(baseUrl)
    var sanitizedUrl = sanitizeUrl(url)
    var rangeRestOfUrl = sanitizedUrl.rangeOfString(sanitizedBase)
    sanitizedUrl.removeRange(rangeRestOfUrl!)
    return sanitizedUrl.stringByReplacingOccurrencesOfString(".", withString: "")
}

// MARK: - Regex Syntax
class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        var error: NSError?
        self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: &error)!
    }
    
    func test(input: String) -> Bool {
        let range = NSMakeRange(0, input.length)
        let matches = self.internalExpression.matchesInString(input, options: nil, range:range)
        return matches.count > 0
    }
}


