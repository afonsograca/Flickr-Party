//
//  Photo.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import Foundation

struct Photo {
  let title: String
  let url: String

  init(title: String, url: String) {
    self.title = title
    self.url = url
  }
}
