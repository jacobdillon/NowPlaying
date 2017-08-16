//
//  AppDelegate.swift
//  NowPlaying
//
//  Created by Jacob Dillon on 8/13/17.
//  Copyright (c) 2017 jad340. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    let statusMenuController = StatusMenuController()
    Timer.scheduledTimer(timeInterval: 1, target: statusMenuController, selector: #selector(statusMenuController.updateStatusItem), userInfo: nil, repeats: true)
  }

}
