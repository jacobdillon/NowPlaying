//
// Created by Jacob Dillon on 8/14/17.
// Copyright (c) 2017 jad340. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {

  var statusBar = NSStatusBar.system()
  var statusBarItem = NSStatusItem()
  var quitItem = NSMenuItem()
  var name = String()
  var artist = String()
  var playingState: SpotifyState = SpotifyState.paused

  override init() {
    super.init()

    statusBarItem = statusBar.statusItem(withLength: NSVariableStatusItemLength)
    statusBarItem.highlightMode = true

    statusBarItem.menu = NSMenu()

    quitItem = NSMenuItem(title: "Quit", action: #selector(quit(_:)), keyEquivalent: "")
    quitItem.target = self

    statusBarItem.menu!.addItem(quitItem)
  }

  func updateStatusItem() {

    let spotifyCallController = SpotifyCallController()

    let returnedName = spotifyCallController.getCurrentTrackProperty(property: "name")
    let returnedArtist = spotifyCallController.getCurrentTrackProperty(property: "artist")
    let returnedPlayingState = spotifyCallController.getCurrentPlayingStatus()

    if(returnedName != nil && returnedArtist != nil && returnedPlayingState != nil) {

      if(returnedName != name || returnedArtist != artist || returnedPlayingState != playingState) {

        name = returnedName!
        artist = returnedArtist!
        playingState = returnedPlayingState!

        if(playingState == SpotifyState.playing) {
          statusBarItem.title = artist + " - " + name
        } else if(playingState == SpotifyState.paused) {
          statusBarItem.title = "[" + artist + " - " + name + "]"
        }
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