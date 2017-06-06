//
//  Response.swift
//  PaQuRe
//
//  Created by Roderic Linguri.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import Foundation

class Response {
  
  // MARK: - Properties
  
  var success: Bool
  
  var count : Int
  
  var object : String
  
  var action: String
  
  var message : String
  
  var data : [Any]
  
  // MARK: - Methods
  
  // Init with Metadata and Data
  init(metadata: [String:Any], data: [Any]?) {
    
    if let s = metadata["success"] as? Bool {
      self.success = s
    } else {
      self.success = false
    }
    
    if let c = metadata["count"] as? Int {
      self.count = c
    } else {
      self.count = 0
    }
    
    if let o = metadata["object"] as? String {
      self.object = o
    } else {
      self.object = "nil"
    }
    
    if let a = metadata["action"] as? String {
      self.action = a
    } else {
      self.action = "nil"
    }
    
    if let m = metadata["message"] as? String {
      self.message = m
    } else {
      self.message = ""
    }
    
    if let result = data {
      if result.count > 0 {
        self.data = result
      } else {
        self.data = []
      }
    } else {
      self.data = []
    }
    
  } // ./init
  
  // Init with Error
  init(error: Error) {
    self.success = false
    self.count = 0
    self.object = "connection"
    self.action = "error"
    self.message = "Error: \(error)"
    self.data = []
  } // ./init
  
}
