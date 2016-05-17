//
//  ImageLoaderController.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit


protocol ImageLoaderController {
  func loadImage(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void)
}

extension ImageLoaderController where Self: UIViewController {
  func loadImage(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
      completionHandler(data, response, error)
      }.resume()
  }
}
