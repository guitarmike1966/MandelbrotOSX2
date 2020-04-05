//
//  ViewController.swift
//  MandelbrotOSX2
//
//  Created by Michael O'Connell on 4/3/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var imageCounter: Int = 0

    @IBOutlet weak var MandelbrotView: CustomView!
    // @IBOutlet weak var MandelbrotImageView: CustomImageView!
    @IBOutlet weak var NextButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // let tempView = CustomView(frame: MandelbrotView.frame)
    }


    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func NextButtonClick(_ sender: Any) {

//        let bitmapImageRep = MandelbrotView.bitmapImageRepForCachingDisplay(in: MandelbrotView.visibleRect)

//        let tempImage = NSImage(size: NSSize(width: MandelbrotView.frame.width, height: MandelbrotView.frame.height))
//        tempImage.addRepresentation(bitmapImageRep!)

        var timeStamp = Date()
        print("NSViewController:NextButtonClick() start: \(timeStamp)")

        let tempImage = MandelbrotView.image()

        timeStamp = Date()
        print("NSViewController:NextButtonClick() midpoint: \(timeStamp)")

        let downloadURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        imageCounter += 1
        let fileName = String(format: "mandelbrot-%04d.png", imageCounter)
        let destinationURL = downloadURL.appendingPathComponent(fileName)
        let saveResult = tempImage.pngWrite(to: destinationURL)
        // print("save result: \(saveResult)")
        // print("image information: \(tempImage.pngData)")

        timeStamp = Date()
        print("NSViewController:NextButtonClick() ready to resize: \(timeStamp)")

        // MandelbrotView.xa += 0.1
        MandelbrotView.xb -= 0.02
        MandelbrotView.ya += 0.01
        MandelbrotView.yb -= 0.01

        let rect = MandelbrotView.visibleRect
        MandelbrotView.setNeedsDisplay(rect)

        timeStamp = Date()
        print("NSViewController:NextButtonClick() end: \(timeStamp)")
    }

}

