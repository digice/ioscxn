//
//  ConnectionManager.swift
//  iOSCxn
//
//  Created by Roderic Linguri.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol ConnectionManagerDelegate {
  func connectionDidComplete(response: Response)
}

// MARK: - Class

class ConnectionManager {

  // MARK: - Properties
  
  // let connectionManager: ConnectionManager = ConnectionManager.shared
  static let shared: ConnectionManager = ConnectionManager()
  
  var object: Connection
  
  var delegate: ConnectionManagerDelegate?
  
  var request: Request?
  
  var response: Response?
  
  var message: String = ""
  
  // MARK: - Methods
  
  // Init
  private init() {
    if let storedData = UserDefaults.standard.object(forKey: "connection") as? Data {
      if let storedConnection = NSKeyedUnarchiver.unarchiveObject(with: storedData) as? Connection {
        self.object = storedConnection
      } else {
        self.object = Connection()
        self.saveDefault()
      }
    } else {
      self.object = Connection()
      self.saveDefault()
    }
  } // ./init
  
  // Save Default
  func saveDefault() {
    let defaults = UserDefaults.standard
    let dataToSave = NSKeyedArchiver.archivedData(withRootObject: self.object)
    defaults.set(dataToSave, forKey: "connection")
    defaults.synchronize()
  } // ./saveDefault
  
  // Completion Handler
  func completionHandler(data: Data?, response: URLResponse?, error: Error?) {
    
    if let e = error {
      self.response = Response(error: e)
    }
    
    if let receivedData = data {
      
      do {
        if let json = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments) as? [String:Any] {

          // DEBUG
          dump(json)
          
          if let metadata = json["meta"] as? [String:Any] {
            var responseData: [Any]? = nil
            if let result = json["data"] as? [Any] {
              responseData = result
            } // ./data in json
            self.response = Response(metadata: metadata, data: responseData)
          } // ./metadata in json
        } // ./data is json
      } catch let e {
        self.response = Response(error: e)
      } // ./do-catch
      
    } // ./data received
    
    OperationQueue.main.addOperation {
      if let delegate = self.delegate {
        delegate.connectionDidComplete(response: self.response!)
      }
    } // ./addOperation
    
  } // ./completionHandler
  
  // Send Request
  func sendRequest() {
    if let request = self.request?.urlRequest() {
      let session = URLSession.shared
      let task = session.dataTask(with: request, completionHandler: self.completionHandler)
      task.resume()
    }
  } // ./sendRequest

  // Set Request
  func setRequest(object: String, action: String, attributes: [String:String]?) {
    self.request = Request(url: self.object.url, key: self.object.key, method: self.object.method)
    self.request!.setValue(action, forKey: "action")
    self.request!.setValue(object, forKey: "object")
    if let attr = attributes {
      for (key, value) in attr {
        self.request!.setValue(value, forKey: key)
      }
    }
  } // ./setRequest
  
}
