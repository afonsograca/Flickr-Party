//
//  AppDelegate.swift
//  Flickr Party
//
//  Created by Afonso Graça on 17/05/16.
//  Copyright © 2016 Afonso Graça. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    setup()

    return true
  }

  func applicationWillResignActive(application: UIApplication) {
  }

  func applicationDidEnterBackground(application: UIApplication) {
  }

  func applicationWillEnterForeground(application: UIApplication) {
  }

  func applicationDidBecomeActive(application: UIApplication) {
  }

  func applicationWillTerminate(application: UIApplication) {
  }


}

// MARK: - Setup Methods
extension AppDelegate {
  func setup() {
    setDefaultSearchTag()
    //let photos = loadPhotos()
    let photosViewModel = PhotosTableViewModel(style: .Plain)
    let photoViewModel = PhotoViewModel(photo: nil)

    let photosTableViewController = PhotosTableViewController(viewModel: photosViewModel)
    let photoViewController = PhotoViewController(viewModel: photoViewModel)

    let navigationViewController = UINavigationController(
      rootViewController: photosTableViewController)

    let splitViewController = UISplitViewController()
    splitViewController.viewControllers = [navigationViewController, photoViewController]
    splitViewController.delegate = self
    splitViewController.preferredDisplayMode = .AllVisible

    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = splitViewController
    window?.makeKeyAndVisible()
  }
}
// MARK: - UISplitViewController Delegate Methods
extension AppDelegate: UISplitViewControllerDelegate {
  func splitViewController(splitViewController: UISplitViewController,
    collapseSecondaryViewController secondaryViewController: UIViewController,
    ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
    return true
  }
}

// MARK: - Flickr data related methods
extension AppDelegate {

  func setDefaultSearchTag() {
    guard NSUserDefaults.standardUserDefaults().stringForKey("FlickrSearchTag") != nil else {
      return
    }
    NSUserDefaults.standardUserDefaults().setObject("party", forKey: "FlickrSearchTag")
  }

  func loadPhotos() -> [Photo] {
    var photos = [Photo]()
    guard let path = NSBundle.mainBundle().pathForResource("stub", ofType: "json") else {
      print("Invalid filename/path.")
      return photos
    }
    do {
      var data = try NSData(contentsOfFile: path,
                                options: .DataReadingMappedIfSafe)
      var dataString = String(data: data, encoding: NSUTF8StringEncoding)!
      dataString = dataString.stringByReplacingOccurrencesOfString("\\'", withString: "'")
      data = dataString.dataUsingEncoding(NSUTF8StringEncoding)!

      guard let json = try NSJSONSerialization.JSONObjectWithData(data,
      options: .MutableContainers) as? [String: AnyObject],
        items = json["items"] as? [[String: AnyObject]] else {
          return photos
      }

      for item: [String: AnyObject] in items {
        guard let title = item["title"] as? String,
          media = item["media"] as? [String: AnyObject],
          mediaUrl = media["m"] as? String else {
            return photos
        }
        photos.append(Photo(title: title, url: mediaUrl))
      }

    } catch let error as NSError {
      print(error.localizedDescription)
    }
    return photos
  }
}
