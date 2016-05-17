//
//  PhotosTableViewModel.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

struct PhotosTableViewModel {
  let photos: [Photo]
  let style: UITableViewStyle

  init(photos: [Photo], style: UITableViewStyle) {
    self.photos = photos
    self.style = style
  }
}

// MARK: - CRUD Methods
extension PhotosTableViewModel {
  func titleForPhotoAtIndex(index: Int) -> String? {
    guard index < photos.count else {
      return nil
    }
    return photos[index].title
  }
}
