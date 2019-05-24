
import UIKit
import SpriteKit
import MetalKit
import Foundation

public class GameScene: SKScene {
    
    var fatherView: UIView!
    var vertOne: SKSpriteNode!
    var vertTwo: SKSpriteNode!
    var vertTree: SKSpriteNode!
    var button: SKSpriteNode!
    var threeDButton: SKLabelNode!
    var rotationButton: SKLabelNode!
    var resetButton: SKLabelNode!
    var tridimensionality: Bool = false
    var allowRotate: Bool = false
    var allowReset: Bool = false
    var auxiliar: String = ""
    
    public init(size: CGSize, fatherView: UIView) {
        super.init(size: size)
        self.backgroundColor = UIColor.clear
        self.fatherView = fatherView
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func didMove(to: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //let pinch = UIPinchGestureRecognizer(target: self, action: handlePinch(sender:))
        setNodes()
    }
    
//    @objc func handlePinch(sender: UIPinchGestureRecognizer) {
//
//    }
    
    func setNodes() {
        vertOne = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: 100))
        vertOne.name = "vertOne"
        vertOne.alpha = 0.3
        vertOne.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        vertOne.position = CGPoint(x: 0, y: 200)
        addChild(vertOne)
        
        vertTwo = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100, height: 100))
        vertTwo.name = "vertTwo"
        vertTwo.alpha = 0.3
        vertTwo.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        vertTwo.position = CGPoint(x: 100, y: -50)
        addChild(vertTwo)
        
        vertTree = SKSpriteNode(color: UIColor.green, size: CGSize(width: 100, height: 100))
        vertTree.name = "vertTree"
        vertTree.alpha = 0.3
        vertTree.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        vertTree.position = CGPoint(x: -100, y: -50)
        addChild(vertTree)
        
        threeDButton = SKLabelNode(text: "3D: off")
        threeDButton.name = "3d"
        threeDButton.position = CGPoint(x: 160, y: 140)
        threeDButton.horizontalAlignmentMode = .center
        threeDButton.verticalAlignmentMode = .center
        addChild(threeDButton)
        
        rotationButton = SKLabelNode(text: "Rotation: off")
        rotationButton.name = "rotation"
        rotationButton.position = CGPoint(x: 160, y: 110)
        rotationButton.horizontalAlignmentMode = .center
        rotationButton.verticalAlignmentMode = .center
        addChild(rotationButton)
        
        resetButton = SKLabelNode(text: "Reset")
        resetButton.name = "reset"
        resetButton.position = CGPoint(x: 160, y: 80)
        resetButton.horizontalAlignmentMode = .center
        resetButton.verticalAlignmentMode = .center
        addChild(resetButton)
        
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                switch node.name {
                case threeDButton.name:
                    tridimensionality = tridimensionality ? false : true
                    threeDButton.text = (threeDButton.text == "3D: off") ? "3D: on" : "3D: off"
                    sendData(buttonPos: catchData())
                    break
                case rotationButton.name:
                    allowRotate = allowRotate ? false : true
                    rotationButton.text = (rotationButton.text == "Rotation: off") ? "Rotation: on" : "Rotation: off"
                    sendData(buttonPos: catchData())
                    break
                case resetButton.name:
                    allowReset = true
                    sendData(buttonPos: catchData())
                default:
                    node.alpha = 1.0
                    auxiliar = node.name!
                    break
                }
            }
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                if node.name! == auxiliar {
                     node.position = location
                }
            }
            sendData(buttonPos: catchData())
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                switch node.name {
                case threeDButton.name:
                    node.alpha = 1.0
                    break
                case rotationButton.name:
                    node.alpha = 1.0
                    break
                case resetButton.name:
                    node.alpha = 1.0
                    allowReset = false
                    threeDButton.text = (threeDButton.text == "3D: on") ? "3D: off" : "3D: off"
                    rotationButton.text = (rotationButton.text == "Rotation: on") ? "Rotation: off" : "Rotation: off"
                    
                default:
                    node.alpha = 0.3
                    auxiliar = ""
                    break
                }
            }
        }
    }
    
    func catchData() -> [vector_float4] {
        
        if allowReset {
            vertOne.position = CGPoint(x: 0, y: 200)
            vertTwo.position = CGPoint(x: 100, y: -50)
            vertTree.position = CGPoint(x: -100, y: -50)
            tridimensionality = false
            allowRotate = false
            return [[-2.0, -1.0, 0.0, 1.0],
                    [ 2.0, -1.0, 0.0, 1.0],
                    [ 0.0,  3.0, 0.0, 1.0]]
        } else {
            return [[Float(vertOne.position.x / (self.view!.frame.width)/0.1), Float(vertOne.position.y / (self.view!.frame.height/7)), 0.0, 1.0],
                    [Float(vertTwo.position.x / (self.view!.frame.width)/0.1), Float(vertTwo.position.y / (self.view!.frame.height/7)), 0.0, 1.0],
                    [Float(vertTree.position.x / (self.view!.frame.width)/0.1), Float(vertTree.position.y / (self.view!.frame.height/7)), -2.0, 1.0]]
        }
    }
    
    func sendData(buttonPos: [vector_float4]){
        var indexData: [UInt16] = [0, 1, 2]
        var vertexData: [Vertex] = [
                Vertex(pos: buttonPos[2],
                       col: Color.green),
                Vertex(pos: buttonPos[1],
                       col: Color.blue),
                Vertex(pos: buttonPos[0],
                       col: Color.red)]
        if self.tridimensionality {
            vertexData.append(Vertex(pos: [0.0, -1.0, 4.0, 1.0],
                                     col: Color.white))
            indexData = [0, 1, 2,
                         0, 1, 3,
                         0, 2, 3,
                         1, 2, 3]
        }
        
        for view in self.fatherView.subviews {
            guard let mtkView = view as? MTKView else {
                return
            }
            guard let delegate = mtkView.delegate as? Renderer else {
                return
            }
            delegate.updateForm(vertexData: vertexData,
                                indexData: indexData,
                                tridimensionality: self.tridimensionality,
                                allowRotate: self.allowRotate,
                                allowReset: self.allowReset)
        }
    }
}
