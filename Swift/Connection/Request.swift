//
//  Request.swift
//  PaQuRe
//
//  Created by Roderic Linguri.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class Request {
  
  // MARK: - Properties
  
  var urlString: String
  
  let apiKey: String
  
  var params: [String:String]
  
  var httpMethod: String
  
  // MARK: - Requesr (self)
  
  // Init
  init(url: String, key: String, method: String) {
    self.urlString = url
    self.apiKey = key
    self.httpMethod = method
    self.params = [:]
  } // ./init
  
  // Set Value For Key
  func setValue(_ value: Any, forKey key: String) {
    self.params[key] = "\(value)"
  } // ./setValue
  
  // URL Request
  func urlRequest() -> URLRequest? {
    
    var body = "api_key=\(self.apiKey)"
    
    for (key, value) in params {
      body.append("&\(key)=\(value)")
    }
    
    print("body: \(body)")
    
    if let url = URL(string: self.urlString) {
      var req = URLRequest(url: url)
      req.httpMethod = self.httpMethod
      req.httpBody = body.data(using: .utf8)
      return req
    }
    
    return nil
    
  } // ./urlRequest
  
}
