//
//  PhotosTableViewController.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {

  let viewModel: PhotosTableViewModel
  init(viewModel: PhotosTableViewModel) {
    self.viewModel = viewModel
    super.init(style: viewModel.style)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - Setup
extension PhotosTableViewController {
  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
}

// MARK: - TableView Data Source Methods
extension PhotosTableViewController {
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.photos.count
  }

  override func tableView(tableView: UITableView,
                          cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
    cell.textLabel?.text = viewModel.titleForPhotoAtIndex(indexPath.row)

    return cell
  }
}

// MARK: - TableView Delegate Methods
extension PhotosTableViewController {

}
