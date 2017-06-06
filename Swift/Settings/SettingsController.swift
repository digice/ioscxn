//
//  SettingsController.swift
//  PaQuRe
//
//  Created by Roderic Linguri.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

  let objects: [String] = ["Connection"]

  override func awakeFromNib() {
    super.awakeFromNib()
    self.title = "Settings"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.objects.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let title = self.objects[indexPath.row]
    let cell = UITableViewCell()
    cell.textLabel?.text = title
    cell.imageView?.image = UIImage(named:  "\(title)_30pt")
    cell.accessoryType = .disclosureIndicator
    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "SettingsShow\(self.objects[indexPath.row])", sender: self)
  }

}
