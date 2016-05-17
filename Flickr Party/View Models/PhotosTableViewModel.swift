//
//  PhotosTableViewModel.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

struct PhotosTableViewModel {
  private let photos: [PhotoViewModel]
  let style: UITableViewStyle

  init(photos: [Photo], style: UITableViewStyle) {
    self.photos = photos.map { PhotoViewModel(photo: $0) }
    self.style = style
  }
}

// MARK: - CRUD Methods
extension PhotosTableViewModel {
  func numberOfPhotos() -> Int {
    return photos.count
  }

  func titleForPhotoAtIndex(index: Int) -> String? {
    guard index < photos.count else {
      return nil
    }
    return photos[index].titleForPhoto()
  }

  func photoViewModelForPhotoAtIndex(index: Int) -> PhotoViewModel? {
    guard index < photos.count else {
      return nil
    }
    return photos[index]
  }
}
