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

    var statusBar = NSStatusBar.system()
    var statusBarItem : NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    var menuItem : NSMenuItem = NSMenuItem()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBarItem = statusBar.statusItem(withLength: NSVariableStatusItemLength)
        statusBarItem.highlightMode = true

        statusBarItem.menu = NSMenu()

        let quitItem : NSMenuItem = NSMenuItem(title: "Quit", action: #selector(quit(_:)), keyEquivalent: "")
        statusBarItem.menu!.addItem(quitItem)

        Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(updateStatusItemTitle), userInfo: nil, repeats: true)
    }

    func updateStatusItemTitle() {
        let track = spotifyCall(command: "get name of current track")
        let artist = spotifyCall(command: "get artist of current track")
        let playingState = spotifyCall(command: "get player state")

        if(track != nil && artist != nil && playingState != nil) {
            if(playingState == "kPSP") {
                statusBarItem.title = artist! + " - " + track!
            } else if(playingState == "kPSp") {
                statusBarItem.title = "[" + artist! + " - " + track! + "]"
            }

            statusBarItem.isVisible = true;
        } else {
            statusBarItem.isVisible = false;
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

    func quit(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

}
