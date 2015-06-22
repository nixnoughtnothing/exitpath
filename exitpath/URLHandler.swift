//
//  URLHandler.swift
//  exitpath
//
//  Created by Nicholas Maccharoli on 6/22/15.
//  Copyright (c) 2015 Nicholas Maccharoli. All rights reserved.
//

import Foundation

typealias LinkHandler = (String, Dictionary<String, String>) -> Void

class LinkDispatch {

    private var actionForPath : Dictionary<String, LinkHandler>
    private var baseUrl : String

    init (baseUrl : String) {
        self.baseUrl = baseUrl
        actionForPath = [String:LinkHandler]()
    }

    func urlClicked(url : String){

        let getParameters = extractGetParamenters(url)
        let urlPathComponents = extractUrlPath(url, self.baseUrl)
        let fullPath = urlPathComponents.count > 1 ? urlPathComponents.reduce("", combine: { $0 + $1 + "/"} ) : urlPathComponents[0]
        if let matchedClosure : LinkHandler = self.actionForPath[fullPath] {
            matchedClosure(url, getParameters)
        }
    }

    func handleUrlWithPath( urlPath : String, handler : LinkHandler){
        actionForPath[urlPath] = handler
    }

    func handleUrlWithPaths( urlPaths : [String], handler : LinkHandler){
        urlPaths.map { self.actionForPath[$0] = handler }
    }

}