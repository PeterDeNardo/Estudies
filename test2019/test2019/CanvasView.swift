//
//  CanvasView.swift
//  test2019
//
//  Created by Peter De Nardo on 06/02/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var lineColor : UIColor!
    var lineWidth : CGFloat!
    var path : UIBezierPath!
    var touchPoint : CGPoint!
    var startingPoint : CGPoint!
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        
        lineColor = UIColor.black
        lineWidth = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint = touch?.location(in: self)
        
//        let circleLayer = CAShapeLayer();
//        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 50, y: 50, width: 100, height: 100)).cgPath;
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: self)
        
        path = UIBezierPath()
        path.move(to: startingPoint)
        path.addLine(to: touchPoint)
        startingPoint = touchPoint
        
        drawShapeLayer()
    }
    
    func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
        self.setNeedsDisplay()
    }
    
    func clearCanvar() {
        path.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
