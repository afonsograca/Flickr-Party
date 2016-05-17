//
//  PhotoViewController.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, PresentableViewController {

  let viewModel: PhotoViewModel
  let scrollView: UIScrollView
  let imageView: UIImageView
  let noImageLabel: UILabel

  init(viewModel: PhotoViewModel) {
    self.viewModel = viewModel
    scrollView = UIScrollView()
    imageView = UIImageView()
    noImageLabel = UILabel()

    super.init(nibName: nil, bundle: nil)
    configure()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - Configure and Setup Methods
extension PhotoViewController: PresentableImageScrollView, ImageLoaderController {
  func configure() {
    view.backgroundColor = backgroundColor
  }
  func setup() {
    if viewModel.containsPhoto() {
      setupImageView()
    } else {
      setupNoImageLabel()
    }
  }

  func setupNoImageLabel() {
    noImageLabel.text = "No photo selected."

    noImageLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(noImageLabel)
    noImageLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    noImageLabel.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
  }

  func setupImageView() {
    guard let url = viewModel.urlForPhoto() else {
      return
    }

    scrollView.delegate = self
    scrollView.minimumZoomScale = minZoom
    scrollView.maximumZoomScale = maxZoom
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)

    scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
    scrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
    scrollView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
    scrollView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true


    loadImage(url) { [weak self] data, response, error in
      guard let strongSelf = self else {
        return
      }
      dispatch_async(dispatch_get_main_queue()) { () -> Void in
        guard let data = data where error == nil else { return }
        strongSelf.imageView.image = UIImage(data: data)

        strongSelf.imageView.contentMode = .ScaleAspectFit
        strongSelf.imageView.translatesAutoresizingMaskIntoConstraints = false
        strongSelf.scrollView.addSubview(strongSelf.imageView)

        strongSelf.imageView.centerXAnchor.constraintEqualToAnchor(
          strongSelf.scrollView.centerXAnchor).active = true
        strongSelf.imageView.centerYAnchor.constraintEqualToAnchor(
          strongSelf.scrollView.centerYAnchor).active = true

      }
    }
  }
}

// MARK: - Scroll View Delegate Methods
extension PhotoViewController: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}
