//
// Created by Jacob Dillon on 8/14/17.
// Copyright (c) 2017 jad340. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {

  var statusBar = NSStatusBar.system()
  var statusBarItem = NSStatusItem()
  var menuItem = NSMenuItem()

  override init() {

    statusBarItem = statusBar.statusItem(withLength: NSVariableStatusItemLength)
    statusBarItem.highlightMode = true

    statusBarItem.menu = NSMenu()

    let quitItem: NSMenuItem = NSMenuItem(title: "Quit", action: #selector(quit(_:)), keyEquivalent: "")

    statusBarItem.menu!.addItem(quitItem)
  }

  func updateStatusItem() {

    let spotifyCallController = SpotifyCallController()

    let name = spotifyCallController.getCurrentTrackProperty(property: "name")
    let artist = spotifyCallController.getCurrentTrackProperty(property: "artist")
    let playingState = spotifyCallController.getCurrentPlayingStatus()

    if(name != nil && artist != nil && playingState != nil) {
      if(playingState == SpotifyState.playing) {
        statusBarItem.title = artist! + " - " + name!
      } else if(playingState == SpotifyState.paused) {
        statusBarItem.title = "[" + artist! + " - " + name! + "]"
      }

      statusBarItem.isVisible = true;
    } else {
      statusBarItem.isVisible = false;
    }
  }

  func quit(_ sender: NSMenuItem) {

    NSApplication.shared().terminate(self)
  }

}