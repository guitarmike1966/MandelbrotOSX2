//
//  ViewController.swift
//  MandelbrotOSX2
//
//  Created by Michael O'Connell on 4/3/20.
//  Copyright © 2020 Michael O'Connell. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var MandelbrotView: CustomView!
    @IBOutlet weak var NextButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func NextButtonClick(_ sender: Any) {
        // MandelbrotView.xa += 0.1
        MandelbrotView.xb -= 0.02
        MandelbrotView.ya += 0.01
        MandelbrotView.yb -= 0.01

        let rect = MandelbrotView.visibleRect
        MandelbrotView.setNeedsDisplay(rect)
    }
    
}

