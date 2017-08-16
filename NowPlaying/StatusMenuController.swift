//
// Created by Jacob Dillon on 8/14/17.
// Copyright (c) 2017 jad340. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {

  var statusBar = NSStatusBar.system()
  var statusBarItem = NSStatusItem()
  var quitItem = NSMenuItem()

  override init() {
    super.init()

    statusBarItem = statusBar.statusItem(withLength: NSVariableStatusItemLength)
    statusBarItem.highlightMode = true

    statusBarItem.menu = NSMenu()

    quitItem = NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "")
    quitItem.target = self

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

  func quit() {

    NSApplication.shared().terminate(self)
  }

}