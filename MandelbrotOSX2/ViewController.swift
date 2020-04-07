//
//  ViewController.swift
//  MandelbrotOSX2
//
//  Created by Michael O'Connell on 4/3/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var MandelbrotImageView: NSImageView!
    // @IBOutlet weak var MandelbrotView: CustomView!
    @IBOutlet weak var NextButton: NSButton!

    var imageCounter: Int = 0

    var xa: Double = -2.0
    var xb: Double = 1.0

    var ya: Double = -1.25
    var yb: Double = 1.25

    override func viewDidLoad() {
        var timeStamp = Date()
        print("NSViewController:viewDidLoad() start: \(timeStamp)")

        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // let tempView = CustomView(frame: MandelbrotView.frame)
        
        timeStamp = Date()
        print("NSViewController:viewDidLoad() end: \(timeStamp)")
    }


    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    override func viewDidDisappear() {
        var timeStamp = Date()
        print("NSViewController:viewDidDisappear(): \(timeStamp)")
    }


    override func viewWillDisappear() {
        var timeStamp = Date()
        print("NSViewController:viewWillDisappear(): \(timeStamp)")
    }


    override func viewWillLayout() {
        var timeStamp = Date()
        print("NSViewController:viewWillLayout(): \(timeStamp)")
    }


    override func viewWillAppear() {
        var timeStamp = Date()
        print("NSViewController:viewWillAppear(): \(timeStamp)")
    }


    override func viewDidLayout() {
        var timeStamp = Date()
        print("NSViewController:viewDidLayout(): \(timeStamp)")
    }


    override func viewDidAppear() {
        var timeStamp = Date()
        print("NSViewController:viewDidAppear(): \(timeStamp)")
    }


    @IBAction func NextButtonClick(_ sender: Any) {

//        let bitmapImageRep = MandelbrotView.bitmapImageRepForCachingDisplay(in: MandelbrotView.visibleRect)

//        let tempImage = NSImage(size: NSSize(width: MandelbrotView.frame.width, height: MandelbrotView.frame.height))
//        tempImage.addRepresentation(bitmapImageRep!)

        var timeStamp = Date()
        print("NSViewController:NextButtonClick() start: \(timeStamp)")

//        let rect = MandelbrotImageView.visibleRect
//        MandelbrotImageView.setNeedsDisplay(rect)

        for x in 0..<800 {

            timeStamp = Date()
            print("\nNSViewController:NextButtonClick() loop start: \(timeStamp)")

            timeStamp = Date()
            print("                                      point A: \(timeStamp)")

            let tempImage = CustomImageView(frame: NSRect(x: 0, y: 0, width: 800, height: 600))

            tempImage.xa = self.xa
            tempImage.xb = self.xb
            tempImage.ya = self.ya
            tempImage.yb = self.yb

            timeStamp = Date()
            print("                                      point B: \(timeStamp)")

            tempImage.draw(NSRect(x: 0, y: 0, width: 800, height: 600))

            timeStamp = Date()
            print("                                      point C: \(timeStamp)")

            MandelbrotImageView.image = tempImage.image

            timeStamp = Date()
            print("                                      point D: \(timeStamp)")

            let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
            imageCounter += 1
            let fileName = String(format: "mandelbrot-%04d.png", imageCounter)
            let destinationURL = downloadURL.appendingPathComponent(fileName)
            let saveResult = tempImage.image!.pngWrite(to: destinationURL)

            timeStamp = Date()
            print("                                      point E: \(timeStamp)")

            // shrink by 1%

            let xWidth = self.xb - self.xa
            let xHeight = self.yb - self.ya

            let xShrink = xWidth * 0.00010
            let yShrink = xHeight * 0.00010

            self.xa += (xShrink * 2)
            self.xb -= (xShrink * 8)
            self.ya += (yShrink * 5)
            self.yb -= (yShrink * 5)

            timeStamp = Date()
            print("NSViewController:NextButtonClick() loop end: \(timeStamp)")

        }

        timeStamp = Date()
        print("NSViewController:NextButtonClick() end: \(timeStamp)")
    }

}

