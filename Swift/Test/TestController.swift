//
//  TestController.swift
//  iOSCxn
//
//  Created by Digices LLC on 6/8/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class TestController: UIViewController, UITextFieldDelegate, TestManagerDelegate {

  // MARK: - IBOutlets

  @IBOutlet weak var scrollView: UIScrollView!

  @IBOutlet weak var contentView: UIView!

  @IBOutlet weak var formView: UIView!

  @IBOutlet weak var iconView: UIImageView!

  @IBOutlet weak var idField: UITextField!

  @IBOutlet weak var createdField: UITextField!

  @IBOutlet weak var updatedField: UITextField!

  @IBOutlet weak var firstField: UITextField!

  @IBOutlet weak var lastField: UITextField!

  @IBOutlet weak var submitButton: UIButton!

  @IBOutlet weak var messageLabel: UILabel!

  // MARK: - Properties

  let manager: TestManager = TestManager.shared

  var position: CGPoint = CGPoint(x: 0, y: 0)

  var typing: Bool = false

  // MARK: - TestController (self)

  func updateViewFromData() {

    if let object = self.manager.object {

      if let id = object.id {
        self.idField.text = "\(id)"
      } // ./id is some

      if let created = object.created {
        self.createdField.text = "\(created)"
      } // ./created is some

      if let updated = object.updated {
        self.updatedField.text = "\(updated)"
      } // ./updated is some

      if let first = object.first {
        self.firstField.text = first
      } // ./first is some

      if let last = object.last {
        self.lastField.text = last
      } // ./last is some

    }

    self.messageLabel.text = self.manager.message

  } // ./updateViewFromData

  func updateDataFromView() -> Bool {

    var errorMessage: String = ""

    if self.manager.object == nil {
      self.manager.object = Test()
    } // ./object is nil

    // skip id, created, & updated as these are provided by API

    if let firstTxt = self.firstField.text {

      if firstTxt.characters.count > 0 {
        self.manager.object!.first = firstTxt
      } // ./first has chars

      else {
        errorMessage.append("First cannot be empty.\n")
      } // ./first is empty

    } // ./first is some

    else {
      errorMessage.append("First field cannot be nil.\n")
    } // ./first is nil

    if let lastTxt = self.lastField.text {

      if lastTxt.characters.count > 0 {
        self.manager.object!.last = lastTxt
      } // ./last not empty

      else {
        errorMessage.append("Last cannot be empty.\n")
      } // ./last is empty

    } // ./last is some

    else {
      errorMessage.append("Last field cannot be nil.\n")
    } // ./last is nil

    if errorMessage.characters.count > 0 {
      self.messageLabel.text = errorMessage
      return false
    } // ./error not empty

    else {
      return true
    } // ./error is empty

  } // ./updateDataFromView

  func dismissKeyboard() {
    self.view.endEditing(true)
    self.scrollView.setContentOffset(self.position, animated: true)
    self.typing = false
  } // ./dismissKeyboard

  // MARK: - UIViewController

  override func awakeFromNib() {
    super.awakeFromNib()
    self.manager.delegate = self
    self.title = "Test Connection"
    let tabBar = self.navigationController?.tabBarItem
    tabBar?.image = UIImage(named: "Test_30pt")
    tabBar?.title = "Test"
  } // ./awakeFromNib

  override func viewDidLoad() {
    super.viewDidLoad()
    self.firstField.delegate = self
    self.lastField.delegate = self
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
    let image = UIImage(named:"Test_60pt")?.withRenderingMode(.alwaysTemplate)
    self.iconView.tintColor = UIColor(red: 15/255, green: 121/255, blue: 252/255, alpha: 1)
    self.iconView.image = image
    self.updateViewFromData()
    self.scrollView.setContentOffset(self.position, animated: true)
  } // ./viewDidLoad

  // MARK: - UITextFieldDelegate

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.dismissKeyboard()
    return false
  } // ./textFieldShouldReturn

  func textFieldDidBeginEditing(_ textField: UITextField) {
    if self.typing != true {
      self.position = self.scrollView.contentOffset
      let offset = CGPoint(x: 0, y: self.position.y + 128)
      self.scrollView.setContentOffset(offset, animated: true)
      self.typing = true
    }
  }

  // MARK: - TestManagerDelegate

  func testDidReceiveResponse() {
    self.updateViewFromData()
  } // ./testDidReceiveResponse

  // MARK: - IBActions

  @IBAction func submitRequest(_ sender: UIButton) {
    if self.updateDataFromView() == true {
      self.manager.sendCreateRequest()
    } // ./no update error
  } // ./submitRequest

}
