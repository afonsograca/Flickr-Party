//
//  PhotosTableViewModelDelegate.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

protocol PhotosTableViewModelDelegate: class {
  func reloadPhotos(photos: [PhotoViewModel])
}
