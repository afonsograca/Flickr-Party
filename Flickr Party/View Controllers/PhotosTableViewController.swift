//
//  PhotosTableViewController.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {

  var viewModel: PhotosTableViewModel
  init(viewModel: PhotosTableViewModel) {
    self.viewModel = viewModel
    super.init(style: viewModel.style)

    self.viewModel.delegate = self
    self.viewModel.loadPhotos()
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
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
}

// MARK: - TableView Data Source Methods
extension PhotosTableViewController {
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfPhotos()
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
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    guard let photoViewModel = viewModel.photoViewModelForPhotoAtIndex(indexPath.row) else {
      return
    }
    let photoViewController = PhotoViewController(viewModel: photoViewModel)

    splitViewController?.showDetailViewController(photoViewController, sender: self)
  }
}

// MARK: - PhotosTableViewModelDelegate Methods
extension PhotosTableViewController: PhotosTableViewModelDelegate {
  func reloadPhotos(photos: [PhotoViewModel]) {
    viewModel.updatePhotos(photos)
    tableView.reloadData()
  }
}
