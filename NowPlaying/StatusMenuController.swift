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

    let name = spotifyCallController.getCurrentTrackProperty(property: "name")
    let artist = spotifyCallController.getCurrentTrackProperty(property: "artist")
    let playingState = spotifyCallController.getCurrentPlayingStatus()

    if(name != nil && artist != nil && playingState != nil) {
      if(infoChange(name: name!, artist: artist!, playingState: playingState!)) {

        if(playingState == SpotifyState.playing) {
          statusBarItem.title = self.artist + " - " + self.name
        } else if(playingState == SpotifyState.paused) {
          statusBarItem.title = "[" + self.artist + " - " + self.name + "]"
        }
      }

      if(!statusBarItem.isVisible) {
        statusBarItem.isVisible = true
      }
    } else {
      if(statusBarItem.isVisible) {
        statusBarItem.isVisible = false
      }
    }
  }

  func infoChange(name: String, artist: String, playingState: SpotifyState) -> Bool {

    if(name != self.name || artist != self.artist || playingState != self.playingState) {
      self.name = name
      self.artist = artist
      self.playingState = playingState

      return true
    } else {
      return false
    }
  }

  func quit(_ sender: NSMenuItem) {

    NSApplication.shared().terminate(self)
  }

}