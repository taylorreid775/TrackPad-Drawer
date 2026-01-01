//
//  ViewController.swift
//  TrackPad Drawer
//
//  Created by Taylor Reid on 2025-12-31.
//

import Cocoa

class ViewController: NSViewController {

    override func loadView() {
        self.view = DrawingView(frame: NSRect(x: 0, y: 0, width: 800, height: 600))
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.title = "TrackPad Drawer"
    }
}

