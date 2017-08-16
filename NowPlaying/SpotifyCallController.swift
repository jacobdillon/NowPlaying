//
// Created by Jacob Dillon on 8/14/17.
// Copyright (c) 2017 jad340. All rights reserved.
//

import Foundation

class SpotifyCallController {

  func getCurrentTrackProperty(property: String) -> String? {

    let call = "get " + property + " of current track"
    let output = spotifyCall(command: call)

    if(output != nil) {
      return output!
    } else {
      return nil;
    }
  }

  func getCurrentPlayingStatus() -> SpotifyState? {

    let call = "get player state"
    let output = spotifyCall(command: call)

    if(output == "kPSP") {
      return SpotifyState.playing
    } else if(output == "kPSp") {
      return SpotifyState.paused
    } else {
      return nil;
    }
  }

  func spotifyCall(command: String) -> String? {

    let fullCommand = "if application \"Spotify\" is running then tell application \"Spotify\" to " + command

    let commandObject = NSAppleScript(source: fullCommand)
    var error: NSDictionary?

    let output: NSAppleEventDescriptor = commandObject!.executeAndReturnError(&error)

    if(output.stringValue != nil) {
      return output.stringValue!
    } else {
      return nil
    }
  }

}