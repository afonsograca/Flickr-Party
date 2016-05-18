//
//  PresentableViewController.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

protocol PresentableViewController {

}

extension PresentableViewController where Self: UIViewController {
  var backgroundColor: UIColor {
    return .whiteColor()
  }
}

extension PresentableViewController where Self: UITableViewController {
  var backgroundColor: UIColor {
    return .whiteColor()
  }
}
