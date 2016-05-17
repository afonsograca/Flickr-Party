//
//  Globals.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import Foundation

class Globals {
  static var flickrSearchTag: String {
    guard let userTag = NSUserDefaults.standardUserDefaults().stringForKey("FlickrSearchTag") else {
      return "party"
    }
    return userTag
  }
  static var flickrUrl: String {
    return Constants.flickrBaseUrl + flickrSearchTag + Constants.flickrCallbackFormat
  }
}
