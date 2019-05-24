//
//  ViewController.swift
//  Metal
//
//  Created by Peter De Nardo on 28/02/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var label: NSTextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let devices = MTLCopyAllDevices()
        guard let _ = devices.first else {
            fatalError("Your GPU does not support Metal!")
        }
        label.stringValue = "Your system has the following GPU(s):\n"
        for device in devices {
            label.stringValue += "\(device.name!)\n"
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

