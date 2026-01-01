//
//  DrawingView.swift
//  TrackPad Drawer
//
//  Created by Taylor Reid on 2025-12-31.
//

import Cocoa

class DrawingView: NSView {

    var currentStroke: [CGPoint] = []
    var strokes: [[CGPoint]] = []
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        guard let context = NSGraphicsContext.current?.cgContext else {
            return
        }

        context.setStrokeColor(NSColor.systemBlue.cgColor)
        context.setLineWidth(4.0)

        // Draw previously completed strokes
        for stroke in strokes {
            guard stroke.count > 1 else { continue } // need at least a segment
            context.move(to: stroke[0])
            for point in stroke.dropFirst() {
                context.addLine(to: point)
            }
        }
        
        // Stroke once after adding all prior stroke segments
        context.strokePath()
        
        if currentStroke.count > 1 {
              context.move(to: currentStroke[0])
              for point in currentStroke.dropFirst() {
                  context.addLine(to: point)
              }
              context.strokePath() // stroke once after adding all segments
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        currentStroke.append(event.locationInWindow)
        needsDisplay = true
    }
    
    override func mouseDragged(with event: NSEvent) {
        currentStroke.append(event.locationInWindow)
        needsDisplay = true
    }
    
    override func mouseUp(with event: NSEvent) {
        currentStroke.append(event.locationInWindow)
        strokes.append(currentStroke)
        needsDisplay = true
        currentStroke.removeAll()
    }
}
