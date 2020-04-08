//
//  CustomImageView.swift
//  MandelbrotOSX2
//
//  Created by Michael O'Connell on 4/4/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

class CustomImageView: NSImageView {

    var xa: Double = -2.0
    var xb: Double = 1.0

    var ya: Double = -1.25
    var yb: Double = 1.25

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

//        var timeStamp = Date()
//        print("NSImageView:draw() start: \(timeStamp)")

        // Drawing code here.

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue
        let context = CGContext(data: nil, width: 1024, height: 1024, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo)

//        guard let context = NSGraphicsContext.current?.cgContext
//            else
//        {
//            print("Error getting current context")
//            return
//        }

//        print("Successful getting current context")
//
//        context.setStrokeColor(NSColor.red.cgColor)
//        context.stroke(CGRect(x: 50, y: 50, width: 50, height: 50))
//
//        for x in 0..<250 {
//            setPixel(context: context, x: x, y: 200, color: .red)
//        }

        for x in 0..<Int(self.frame.width) {
            for y in 0..<Int(self.frame.height) {
                let color = Mandelbrot(Px: x, Py: y)
                setPixel(context: context!, x: x, y: y, color: color)
            }
        }

//        let bitmapImageRep = self.bitmapImageRepForCachingDisplay(in: self.visibleRect)
//
//        let tempImage = NSImage(size: NSSize(width: self.frame.width, height: self.frame.height))
//        tempImage.addRepresentation(bitmapImageRep!)
//
//        let desktopURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
//        let destinationURL = desktopURL.appendingPathComponent("my-image.png")
//        let saveResult = tempImage.pngWrite(to: destinationURL)
//        print("save result: \(saveResult)")
//        print("image information: \(tempImage.pngData)")

        let xImage = context?.makeImage()
        self.image = NSImage(cgImage: xImage!, size: NSSize(width: xImage!.width, height: xImage!.height))

//        timeStamp = Date()
//        print("NSImageView:draw() end: \(timeStamp)")
    }


    private func setPixel(context: CGContext, x: Int, y: Int, color: NSColor)
    {
        context.setLineWidth(1)
        context.setStrokeColor(color.cgColor)
        context.stroke(CGRect(x: CGFloat(x), y: CGFloat(y), width: 0.5, height: 0.5))
    }


    private func Mandelbrot(Px: Int, Py: Int) -> NSColor {

        let imgx = self.frame.width
        let imgy = self.frame.height

        let x0 = Double(Px) * (xb - xa) / Double(imgx) + xa
        let y0 = Double(Py) * (yb - ya) / Double(imgy) + ya

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

        let red = (iteration % 4) * 64
        let green = (iteration % 8) * 32
        let blue = (iteration % 16) * 16

        let retval: NSColor = NSColor(displayP3Red: CGFloat(red)/CGFloat(256), green: CGFloat(green)/CGFloat(256), blue: CGFloat(blue)/CGFloat(256), alpha: 1)

        // return UIColor.red
        return retval
    }

}


extension NSImage {
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        return bitmapImage.representation(using: .png, properties: [:])
    }
    func pngWrite(to url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do {
            try pngData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
}
