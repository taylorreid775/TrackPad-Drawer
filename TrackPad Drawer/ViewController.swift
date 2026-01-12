//
//  ViewController.swift
//  TrackPad Drawer
//
//  Created by Taylor Reid on 2025-12-31.
//

import Cocoa

class ViewController: NSViewController {
    
    let drawingView = DrawingView()
    let clearButton = NSButton(title: "Clear", target: nil, action: nil)

    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 800, height: 600))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure drawing view
        drawingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(drawingView)

        // Configure button
        clearButton.bezelStyle = .rounded
        clearButton.target = drawingView
        clearButton.action = #selector(DrawingView.clear(_:))
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clearButton)

        NSLayoutConstraint.activate([
            // Button top-right
            clearButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Drawing view fills remaining space below the button
            drawingView.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 12),
            drawingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drawingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drawingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        if let window = view.window {
            window.title = "TrackPad Drawer"
            window.minSize = NSSize(width: 400, height: 300)
        }
    }
}
