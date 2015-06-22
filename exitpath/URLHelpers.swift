//
//  URLHelpers.swift
//  exitpath
//
//  Created by Nicholas Maccharoli on 6/22/15.
//  Copyright (c) 2015 Nicholas Maccharoli. All rights reserved.
//

import Foundation

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
        return [""]
    }

    var latterPart = url.substringFromIndex(baseUrl.endIndex)
    if let eraseFrom = latterPart.rangeOfString("?")?.startIndex {
        latterPart.removeRange(eraseFrom..<latterPart.endIndex)
    }
    return split(latterPart){ $0 == "/" }
}

func sanitizeUrl(var url : String) -> String{
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
