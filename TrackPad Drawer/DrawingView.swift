//
//  DrawingView.swift
//  TrackPad Drawer
//
//  Created by Taylor Reid on 2025-12-31.
//

import Cocoa

class DrawingView: NSView {

    struct Touch {
        let point: CGPoint
        let pressure: CGFloat
    }
    
    private var backingContext: CGContext?
    private var backingImage: CGImage?
    
    var currentStroke: [Touch] = []
    var strokes: [[Touch]] = []
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        guard let context = NSGraphicsContext.current?.cgContext else {
            return
        }

        context.setStrokeColor(NSColor.systemRed.cgColor)
        let minWidth: CGFloat = 1.0
        let maxWidth: CGFloat = 6.0
        
        // Draw completed strokes with per-segment pressure width
        for stroke in strokes {
            drawStroke(stroke, context: context, minWidth: minWidth, maxWidth: maxWidth)
        }
        
        if !currentStroke.isEmpty {
            drawStroke(currentStroke, context: context, minWidth: minWidth, maxWidth: maxWidth)
        }
    }
    
    func drawStroke(_ stroke: [Touch], context: CGContext, minWidth: CGFloat, maxWidth: CGFloat) {
        guard stroke.count > 1 else { return }
        
        //group
        var i = 1
        var currentWidth = widthFor(stroke[1].pressure, minWidth, maxWidth)
        context.setLineWidth(currentWidth)
        context.move(to: stroke[0].point)
        
        while i < stroke.count {
            let w = widthFor(stroke[i].pressure, minWidth, maxWidth)
            
            if abs(w - currentWidth) < 0.25 {
                context.addLine(to: stroke[i].point)
                i += 1
            } else {
                context.strokePath()
                currentWidth = w
                context.setLineWidth(currentWidth)
                context.move(to: stroke[i - 1].point)
                context.addLine(to: stroke[i].point)
                i += 1
            }
        }
        context.strokePath()
    }
    
    func widthFor(_ pressure: CGFloat, _ minWidth: CGFloat, _ maxWidth: CGFloat) -> CGFloat {
        let p = max(0, min(1, pressure))
        return minWidth + p * (maxWidth - minWidth)
    }
    
    override func pressureChange(with event: NSEvent) {
        let p = max(0,event.pressure)
        let loc = convert(event.locationInWindow, from: nil)
        currentStroke.append(Touch(point: loc, pressure: CGFloat(p)))
        needsDisplay = true
    }
    
    override func mouseUp(with event: NSEvent) {
        strokes.append(currentStroke)
        needsDisplay = true
        currentStroke.removeAll()
    }
    
    @objc func clear(_ sender: Any? = nil) {
        strokes.removeAll()
        needsDisplay = true
    }
}

