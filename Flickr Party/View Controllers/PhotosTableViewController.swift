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

  let spinningView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
  init(viewModel: PhotosTableViewModel) {
    self.viewModel = viewModel
    super.init(style: viewModel.style)

    self.viewModel.delegate = self
    self.viewModel.loadPhotos()
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    setupSpinningWheel()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - Configure and Setup Methods
extension PhotosTableViewController: PresentableViewController {
  func configure() {
    view.backgroundColor = backgroundColor
  }

  func setup() {
    setupTableView()
    setupNavigationBar()
  }

  func setupNavigationBar() {
    navigationItem.title = "\(Globals.flickrSearchTag.capitalizedString) Photos"
  }

  func setupSpinningWheel() {
    spinningView.translatesAutoresizingMaskIntoConstraints = false
    spinningView.hidesWhenStopped = true


    spinningView.center = view.center
    view.addSubview(spinningView)

    if tableView.isEmpty() {
      tableView.userInteractionEnabled = false
      spinningView.startAnimating()
    }
  }

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .clearColor()
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
    tableView.userInteractionEnabled = true
    spinningView.stopAnimating()
    tableView.reloadData()
  }
}
