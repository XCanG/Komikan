//
//  KMGradientView.swift
//  Komikan
//
//  Created by Seth on 2016-01-28.
//

import Cocoa

@IBDesignable class KMGradientView: NSView {

    // The color for the start of the gradient
    @IBInspectable var startColor : NSColor = NSColor(calibratedRed: 0, green: 0, blue: 0, alpha: 0.5);
    
    // The color for the end of the gradient
    @IBInspectable var endColor : NSColor = NSColor.clear;
    
    // The angle of the gradient
    var angle : CGFloat = 90;
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        // Set the view to have a core animation layer
        self.wantsLayer = true;
        
        // Draw the gradient
        redrawGradient();
    }
    
    func redrawGradient() {
        // Create the gradient
        let gradient : NSGradient = NSGradient(starting: startColor, ending: endColor)!;
        
        // Draw it in the views rect
        gradient.draw(in: self.bounds, angle: angle);
    }
}
