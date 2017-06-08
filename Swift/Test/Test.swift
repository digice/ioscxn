//
//  Test.swift
//  iOSCxn
//
//  Created by Digices LLC on 6/8/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import Foundation

class Test {

  // MARK: - Properties

  var id: Int?

  var created: Int?

  var updated: Int?

  var first: String?

  var last: String?

  // MARK: - Test (self)

  // init empty object
  init() {

  } // ./init

  // initialize from user interface
  init(first: String, last: String) {
    self.first = first
    self.last = last
  } // ./initWithFirstandLast

  // init from json response
  init(dict: [String:Any]) {

    if let i = dict["id"] as? String {
      if let iNum = Int(i) {
        self.id = iNum
      }
    }

    if let c = dict["created"] as? String {
      if let cNum = Int(c) {
        self.created = cNum
      }
    }

    if let u = dict["updated"] as? String {
      if let uNum = Int(u) {
        self.updated = uNum
      }
    }

    if let f = dict["first"] as? String {
      self.first = f
    }

    if let l = dict["last"] as? String {
      self.last = l
    }

  } // ./initWithDict

}
