//
//  PhotoViewModel.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

struct PhotoViewModel {
  private let photo: Photo?

  init(photo: Photo?) {
    self.photo = photo
  }
}

// MARK: - CRUD Methods
extension PhotoViewModel {
  func containsPhoto() -> Bool {
    return photo != nil
  }

  func titleForPhoto() -> String? {
    return photo?.title
  }

  func urlForPhoto() -> NSURL? {
    guard let urlString = photo?.url else {
      return nil
    }
    return NSURL(string: urlString)
  }
}
