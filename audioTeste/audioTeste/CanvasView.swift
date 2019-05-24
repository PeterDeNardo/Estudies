

import UIKit
import AudioKit

struct drawPos: Codable {
    let posX : Int
    let posY : Int
}

class CanvasView: UIView {

    let path=UIBezierPath()
    var previousPoint:CGPoint
    var lineWidth:CGFloat = 10
    var conductor = Conductor()
    var posArray : [drawPos] = []
    var lineColor : UIColor! = UIColor.white
    
    override init(frame: CGRect) {
        previousPoint=CGPoint.zero
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        previousPoint = CGPoint.zero
        super.init(coder: aDecoder)!
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        lineColor.setStroke()
        path.stroke()
        path.lineWidth = lineWidth
        posArray.append(drawPos(posX: Int(path.currentPoint.x), posY: Int(path.currentPoint.y)))
    }
    
    @objc func pan(panGestureRecognizer:UIPanGestureRecognizer)->Void
    {
        let currentPoint = panGestureRecognizer.location(in: self)
        let midPoint=self.midPoint(p0: previousPoint, p1: currentPoint)
        
        if panGestureRecognizer.state == .began
        {
            path.move(to: currentPoint)
        }
        else if panGestureRecognizer.state == .changed
        {
            path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
        }
        
        previousPoint = currentPoint
        conductor.setOscillator(frequency: Double(currentPoint.x), amplitude: Double(currentPoint.y))
        changueColors()
        self.setNeedsDisplay()
    }
    
    func changueColors() {
        let touchPoint = path.currentPoint
        let color = UIColor(displayP3Red: touchPoint.y/600, green: 0.5, blue: touchPoint.x/350, alpha: 0.8)
        self.backgroundColor = color
        lineColor = color
    }
    
    func midPoint(p0:CGPoint,p1:CGPoint)->CGPoint
    {
        let x=(p0.x+p1.x)/2
        let y=(p0.y+p1.y)/2
        return CGPoint(x: x, y: y)
    }
    
    func saveMusic() {
        let posData = try! PropertyListEncoder().encode(posArray)
        UserDefaults.standard.set(posData, forKey: "melody")
    }

}

