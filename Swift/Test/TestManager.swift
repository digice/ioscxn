//
//  TestManager.swift
//  iOSCxn
//
//  Created by Digices LLC on 6/8/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import Foundation

protocol TestManagerDelegate {
  func testDidReceiveResponse()
}

class TestManager: ConnectionManagerDelegate {

  // MARK: - Properties

  static let shared: TestManager = TestManager()

  var delegate: TestManagerDelegate?

  var object: Test?

  var message: String = ""

  let connection: ConnectionManager = ConnectionManager.shared

  // MARK: - TestManager (self)

  private init() {
    self.connection.delegate = self
  } // ./init

  func sendCreateRequest() {
    self.message = ""
    if let object = self.object {
      if let first = object.first {
        if let last = object.last {
          self.connection.setRequest(object: "test", action: "create", attributes: ["first":first,"last":last])
          self.connection.sendRequest()
        } // ./last is not nil
      } // ./first is not nil
    } // ./object is not nil
  } // ./sendCreateRequest

  // MARK: - ConnectionManagerDelegate

  func connectionDidComplete(response: Response) {

    self.message = response.message

    if response.data.count > 0 {
      if let dict = response.data[0] as? [String:Any] {
        self.object = Test(dict: dict)
      } // ./first item is dict
    } // ./array has at least one item

    if let delegate = self.delegate {
      delegate.testDidReceiveResponse()
    } // ./delegate is not nil

  } // ./connectionDidComplete

}
