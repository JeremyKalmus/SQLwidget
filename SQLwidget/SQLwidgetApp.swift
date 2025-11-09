//
//  SQLwidgetApp.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import SwiftUI

/// Main entry point for the SQL Cheat Sheet menubar application
@main
struct SQLwidgetApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // Empty scene - we only use the menubar
        Settings {
            EmptyView()
        }
    }
}

/// App delegate to manage the menubar controller
class AppDelegate: NSObject, NSApplicationDelegate {
    private var menuBarController: MenuBarController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Initialize the menubar controller
        menuBarController = MenuBarController()

        // Hide the app from the Dock (menubar-only app)
        NSApp.setActivationPolicy(.accessory)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        // Don't quit when popover closes
        return false
    }
}
