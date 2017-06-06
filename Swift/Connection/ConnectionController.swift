//
//  ConnectionController.swift
//  PaQuRe
//
//  Created by Roderic Linguri
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class ConnectionController: UIViewController, UITextFieldDelegate, ConnectionManagerDelegate {

  // MARK: - IBOutlets

  @IBOutlet weak var scrollView: UIScrollView!

  @IBOutlet weak var contentView: UIView!

  @IBOutlet weak var formView: UIView!

  @IBOutlet weak var iconView: UIImageView!

  @IBOutlet weak var methodControl: UISegmentedControl!

  @IBOutlet weak var urlField: UITextField!

  @IBOutlet weak var keyField: UITextField!

  @IBOutlet weak var saveButton: UIButton!

  @IBOutlet weak var messageLabel: UILabel!

  // MARK: - Properties

  let manager = ConnectionManager.shared

  // MARK: - ConnectionController (self)

  func updateViewFromData() {

    let object = self.manager.object

    switch object.method {
    case "GET":
      self.methodControl.selectedSegmentIndex = 0
    case "POST":
      self.methodControl.selectedSegmentIndex = 1
    default:
      self.methodControl.selectedSegmentIndex = 1
    }

    self.urlField.text = object.url
    self.keyField.text = object.key
    self.messageLabel.text = self.manager.response?.message

  }

  func updateDataFromView() {

    if self.methodControl.selectedSegmentIndex == 0 {
      self.manager.object.method = "GET"
    } else {
      self.manager.object.method = "POST"
    }

    if let u = self.urlField.text {
      if u.characters.count > 0 {
        self.manager.object.url = u
      }
    }

    if let k = self.keyField.text {
      if k.characters.count > 0 {
        self.manager.object.key = k
      }
    }

  }

  // MARK: - UIViewController

  override func awakeFromNib() {
    super.awakeFromNib()
    self.title = "Connection"
    self.manager.delegate = self
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.urlField.delegate = self
    self.keyField.delegate = self
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
    let image = UIImage(named:"Connection_60pt")?.withRenderingMode(.alwaysTemplate)
    self.iconView.tintColor = UIColor(red: 15/255, green: 121/255, blue: 252/255, alpha: 1)
    self.iconView.image = image
    self.updateViewFromData()
  }

  // MARK: - UITextFieldDelegate

  func dismissKeyboard() {
    self.view.endEditing(true)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }

  // MARK: - ConnectionManagerDelegate

  func connectionDidComplete(response: Response) {
    self.updateViewFromData()
  }

  // MARK: - IBActions

  @IBAction func save(_ sender: UIButton) {
    self.updateDataFromView()
    self.manager.saveDefault()
  }

}
