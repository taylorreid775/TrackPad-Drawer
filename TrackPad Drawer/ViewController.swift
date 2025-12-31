//
//  ViewController.swift
//  TrackPad Drawer
//
//  Created by Taylor Reid on 2025-12-31.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController loaded")
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.title = "TrackPad Drawer"
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

