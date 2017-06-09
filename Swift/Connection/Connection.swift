//
//  Connection.swift
//  iOSCxn
//
//  Created by Roderic Linguri
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class Connection: NSObject, NSCoding {
  
  // MARK: - Properties
  
  var url: String
  
  var key: String
  
  var method: String
  
  // MARK: - NSObject
  
  // Init
  override init() {
    self.url = "http://localhost/ioscxn/request.php"
    self.key = "9326367bd624dcefd9467db36172c007"
    self.method = "POST"
    super.init()
  } // ./init
  
  // MARK: NSCoding
  
  // Init With Coder
  required init?(coder aDecoder: NSCoder) {
    self.url = aDecoder.decodeObject(forKey: "url") as! String
    self.key = aDecoder.decodeObject(forKey: "key") as! String
    self.method = aDecoder.decodeObject(forKey: "method") as! String
  } // ./init
  
  // Encode With Coder
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.url, forKey: "url")
    aCoder.encode(self.key, forKey: "key")
    aCoder.encode(self.method, forKey: "method")
  } // ./encode
  
}
