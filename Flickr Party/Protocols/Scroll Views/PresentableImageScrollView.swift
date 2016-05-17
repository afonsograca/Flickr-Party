//
//  PresentableImageScrollView.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

protocol PresentableImageScrollView {

}

extension PresentableImageScrollView where Self: UIViewController {
  var minZoom: CGFloat {
    return 1.0
  }
  var maxZoom: CGFloat {
    return 6.0
  }
}
