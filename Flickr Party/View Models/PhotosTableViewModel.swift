//
//  PhotosTableViewModel.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

struct PhotosTableViewModel {
  var photos: [PhotoViewModel]?
  let style: UITableViewStyle

  weak var delegate: PhotosTableViewModelDelegate?

  init(style: UITableViewStyle) {
    self.style = style
  }
}

// MARK: - CRUD Methods
extension PhotosTableViewModel {
  func numberOfPhotos() -> Int {
    guard let photos = photos else {
      return 0
    }
    return photos.count
  }

  func titleForPhotoAtIndex(index: Int) -> String? {
    guard let photos = photos where index < photos.count else {
      return nil
    }
    return photos[index].titleForPhoto()
  }

  func urlForPhotoAtIndex(index: Int) -> NSURL? {
    guard let photos = photos where index < photos.count else {
      return nil
    }
    return photos[index].urlForPhoto()
  }

  func photoViewModelForPhotoAtIndex(index: Int) -> PhotoViewModel? {
    guard let photos = photos where index < photos.count else {
      return nil
    }
    return photos[index]
  }

  mutating func updatePhotos(photos: [PhotoViewModel]) {
    self.photos = photos
  }
}

// MARK: - Load Photos
extension PhotosTableViewModel {
  mutating func loadPhotos() {
    guard let url = NSURL(string: Globals.flickrUrl) else {
      self.photos = [PhotoViewModel]()
      return
    }
    var photos = [PhotoViewModel]()
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
      guard var data = data where error == nil else { return }

      var dataString = String(data: data, encoding: NSUTF8StringEncoding)!
      dataString = dataString.stringByReplacingOccurrencesOfString("\\'", withString: "'")
      data = dataString.dataUsingEncoding(NSUTF8StringEncoding)!

      do {
        guard let json = try NSJSONSerialization.JSONObjectWithData(data,
          options: .MutableContainers) as? [String: AnyObject],
          items = json["items"] as? [[String: AnyObject]] else {
            self.photos = [PhotoViewModel]()
            return
        }

        for item: [String: AnyObject] in items {
          guard let title = item["title"] as? String,
            media = item["media"] as? [String: AnyObject],
            mediaUrl = media["m"] as? String else {
              continue
          }
          let photo = Photo(title: title, url: mediaUrl)
          photos.append(PhotoViewModel(photo: photo))
        }
      } catch let error as NSError {
        print(error.localizedDescription)
      }
      self.delegate?.reloadPhotos(photos)
    }.resume()
  }
}
