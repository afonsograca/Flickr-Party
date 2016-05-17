//
//  Constants.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//
import Foundation

class Constants {
  static let flickrBaseUrl = "https://api.flickr.com/services/feeds/photos_public.gne?tags="
  static let flickrCallbackFormat = "&format=json&nojsoncallback=1"

  static var flickrUrl: String {
    var tag = "party"
    if let userTag = NSUserDefaults.standardUserDefaults().stringForKey("FlickrSearchTag") {
      tag = userTag
    }
    return flickrBaseUrl + tag + flickrCallbackFormat
  }
}
