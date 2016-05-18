//
//  UITableView+isEmpty.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

extension UITableView {
  func isEmpty() -> Bool {
    if numberOfSections > 0 {
      for section in 0..<numberOfSections {
        if numberOfRowsInSection(section) > 0 {
          return false
        }
      }
    }
    return true
  }
}
