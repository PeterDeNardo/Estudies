//
//  ViewController.swift
//  audioTeste
//
//  Created by Peter De Nardo on 08/02/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit
import AudioKit



class ViewController: UIViewController {
    
    @IBOutlet var canvasView: CanvasView!

    var array: [CGPath]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        self.view.clipsToBounds = true
//        self.view.isMultipleTouchEnabled = false
//
//        lineColor = UIColor.black
//        lineWidth = 10
//
//        AudioKit.output = oscillator
//        do {
//            try AudioKit.start()
//        } catch {
//            print(1)
//        }
//        oscillator.start()
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        startingPoint = touch?.location(in: self.view)
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        touchPoint = touch?.location(in: self.view)
//
//        path = UIBezierPath()
//        path.move(to: startingPoint)
//        path.addLine(to: touchPoint)
//        startingPoint = touchPoint
//
//
//        drawShapeLayer()
//
//        changueOcillerConf(frequency: Double(touchPoint.y), amplitude: Double(touchPoint.x/10))
//
//        let color = UIColor(displayP3Red: touchPoint.y/600, green: 0.5, blue: touchPoint.x/350, alpha: 0.8)
//
//        self.view.backgroundColor = color
//        lineColor = color
//    }
//
//
//
//    func changueOcillerConf(frequency: Double, amplitude: Double) {
//        oscillator.frequency = frequency
//        oscillator.amplitude = amplitude
//    }
//
//    func drawShapeLayer() {
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        array.append(path.cgPath)
//        shapeLayer.strokeColor = lineColor.cgColor
//        shapeLayer.lineWidth = lineWidth
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        self.view.layer.addSublayer(shapeLayer)
//        self.view.setNeedsDisplay()
//
//    }
//
//    func clearCanvar() {
//        path.removeAllPoints()
//        self.view.layer.sublayers = nil
//        self.view.setNeedsDisplay()
//    }

    @IBAction func replay(_ sender: Any) {
        canvasView.saveMusic()
        let fetchedData = UserDefaults.standard.data(forKey: "melody")!
        let fetchedPos = try! PropertyListDecoder().decode([drawPos].self, from: fetchedData)
        print(fetchedPos)
        for path in fetchedPos {
            var count = 0
            while ( count != 2500000 ) {
                count += 1
            }
            canvasView.conductor.setOscillator(frequency: Double(path.posX), amplitude: Double(path.posY/10))
        }
    }
    



}


