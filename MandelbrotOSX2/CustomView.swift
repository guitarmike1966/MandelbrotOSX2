//
//  CustomView.swift
//  MandelbrotOSX2
//
//  Created by Michael O'Connell on 4/3/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

class CustomView: NSView {
    
    var xa: Double = -2.0
    var xb: Double = 1.0
    
    var ya: Double = -1.25
    var yb: Double = 1.25
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
        
        guard let context = NSGraphicsContext.current?.cgContext
            else
        {
            print("Error getting current context")
            return
        }
        
        // print("Get Current Context successful")
        
        //        context.setStrokeColor(UIColor.red.cgColor)
        //        context.stroke(CGRect(x: 50, y: 50, width: 50, height: 50))
        
        //        for x in 0..<250 {
        //            setPixel(context: context, x: x, y: 200, color: .red)
        //        }
        
        for x in 0..<Int(self.frame.width) {
            for y in 0..<Int(self.frame.height) {
                let color = Mandelbrot(Px: x, Py: y)
                setPixel(context: context, x: x, y: y, color: color)
            }
        }
        
    }
    
    private func setPixel(context: CGContext, x: Int, y: Int, color: NSColor)
    {
        context.setLineWidth(1)
        context.setStrokeColor(color.cgColor)
        context.stroke(CGRect(x: CGFloat(x), y: CGFloat(y), width: 0.5, height: 0.5))
    }
    
    //    private func getPixel(point: CGPoint) -> NSColor {
    //        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    //        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    //
    //        var pixelData: [UInt8] = [0, 0, 0, 0]
    //
    //        let context = CGContext(data: &pixelData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
    //
    //        context!.translateBy(x: -point.x, y: -point.y)
    //
    //        self.layer.render(in: context!)
    //
    //        let red: CGFloat = CGFloat(pixelData[0]) / CGFloat(255.0)
    //        let green: CGFloat = CGFloat(pixelData[1]) / CGFloat(255.0)
    //        let blue: CGFloat = CGFloat(pixelData[2]) / CGFloat(255.0)
    //        let alpha: CGFloat = CGFloat(pixelData[3]) / CGFloat(255.0)
    //
    //        let color: UIColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    //
    //        return color
    //    }
    
    private func Mandelbrot(Px: Int, Py: Int) -> NSColor {
        
        let imgx = self.frame.width
        let imgy = self.frame.height
        
        let x0 = Double(Px) * (xb - xa) / Double(imgx) + xa
        let y0 = Double(Py) * (yb - ya) / Double(imgy) + ya
        
        //        print("x0: \(x0)")
        //        print("y0: \(y0)")
        
        var x: Double = 0.0
        var y: Double = 0.0
        
        var iteration: Int = 0
        // let max_iteration: Int = 1000
        let max_iteration: Int = 200
        
        
        while (((x * x) + (y * y) <= (2 * 2)) && (iteration < max_iteration)) {
            let xtemp = (x * x) - (y * y) + x0
            y = 2 * x * y + y0
            x = xtemp
            iteration += 1
            
            //        color := palette[iteration]
            //        plot(Px, Py, color)
        }
        
        //        if iteration > 2 {
        //            print("\niteration: \(iteration)")
        //        }
        
        let red = (iteration % 4) * 64
        let green = (iteration % 8) * 32
        let blue = (iteration % 16) * 16
        
        //        if (red > 0) {
        //            print("\n   raw  : \(iteration % 4)")
        //            print("   red  : \(red)")
        //        }
        //
        //        if (green > 0) {
        //            print("\n   raw  : \(iteration % 8)")
        //            print("   green: \(green)")
        //        }
        //
        //        if (blue > 0) {
        //            print("\n   raw  : \(iteration % 16)")
        //            print("   blue : \(blue)")
        //        }
        
        let retval: NSColor = NSColor(displayP3Red: CGFloat(red)/CGFloat(256), green: CGFloat(green)/CGFloat(256), blue: CGFloat(blue)/CGFloat(256), alpha: 1)
        
        // return UIColor.red
        return retval
    }
    
}



/*
 for each pixel (Px, Py) on the screen do
 x0 = scaled x coordinate of pixel (scaled to lie in the Mandelbrot X scale (-2.5, 1))
 y0 = scaled y coordinate of pixel (scaled to lie in the Mandelbrot Y scale (-1, 1))
 x := 0.0
 y := 0.0
 iteration := 0
 max_iteration := 1000
 while (x×x + y×y ≤ 2×2 AND iteration < max_iteration) do
 xtemp := x×x - y×y + x0
 y := 2×x×y + y0
 x := xtemp
 iteration := iteration + 1
 
 color := palette[iteration]
 plot(Px, Py, color)
 */

