//
//  MenuBarController.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import AppKit
import SwiftUI

/// Manages the menubar icon and popover display
class MenuBarController: NSObject {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    override init() {
        super.init()
        setupStatusItem()
        setupPopover()
    }

    private func setupStatusItem() {
        // Create status bar item with variable length
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        // Configure the button
        if let button = statusItem.button {
            // Use SF Symbol for database icon
            button.image = NSImage(systemSymbolName: "cylinder.split.1x2", accessibilityDescription: "SQL Cheat Sheet")
            button.action = #selector(togglePopover)
            button.target = self
        }
    }

    private func setupPopover() {
        popover = NSPopover()
        popover.contentSize = NSSize(width: 750, height: 600)
        popover.behavior = .transient  // Closes when clicking outside
        popover.contentViewController = NSHostingController(rootView: ContentView())
    }

    @objc private func togglePopover() {
        guard let button = statusItem.button else { return }

        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            // Activate the app to ensure the popover receives keyboard events
            NSApp.activate(ignoringOtherApps: true)
        }
    }

    /// Show the popover programmatically
    func showPopover() {
        guard let button = statusItem.button else { return }
        popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        NSApp.activate(ignoringOtherApps: true)
    }

    /// Hide the popover programmatically
    func hidePopover() {
        popover.performClose(nil)
    }
}
