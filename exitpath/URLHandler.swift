//
//  URLHandler.swift
//  exitpath
//
//  Created by Nicholas Maccharoli on 6/22/15.
//  Copyright (c) 2015 Nicholas Maccharoli. All rights reserved.
//
import foundation

typealias URLSelector = (URLComponents) -> Bool
typealias URLAction = (URLComponents) -> Void

public struct URLComponents {
    
    var fullURL : String!
    var baseURL : String!
    
    var pathComponents : [String] {
        get {
            return extractUrlPath(self.fullURL, self.baseURL!)
        }
    }
    
    var getParams : [String : String] {
        get {
            return extractGetParamenters(self.fullURL)
        }
    }
    
}

class URLRouting {
    
    var validatorForID : [String : URLSelector]?
    var actionForID : Dictionary<String, URLAction>?
    
    func actionIDForURL(#URL : String?, baseURL : String) -> String? {
        for (actionID, actionIDSelectorBlock) in self.validatorForID! {
            var urlComponents = URLComponents(fullURL: URL, baseURL: baseURL)
            if actionIDSelectorBlock(urlComponents) {
                return actionID
            }
        }
        return nil;
    }
    
    func actionForActionID(actionID : String) -> URLAction? {
        if let selectedAction = self.actionForID![actionID]{
            return selectedAction
        }
        else {
            return nil
        }
    }
    
    func performActionForURL(#URL : String, baseURL : String){
        var actionID : String = self.actionIDForURL(URL: URL, baseURL: baseURL)!
        if let blockToCall = self.actionForActionID(actionID){
            blockToCall(URLComponents(fullURL: URL, baseURL: baseURL))
        }
        else {
            
        }
        
    }
}