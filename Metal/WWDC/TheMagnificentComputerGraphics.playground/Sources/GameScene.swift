
import UIKit
import SpriteKit
import MetalKit
import Foundation

public class GameScene: SKScene, SKSceneDelegate {
    
    var fatherView: UIView!
    var vertOne: SKShapeNode!
    var vertTwo: SKShapeNode!
    var vertTree: SKShapeNode!
    var vertFourth: SKShapeNode!
    var button: SKShapeNode!
    
    var threeDButton: SKLabelNode!
    var rotationButton: SKLabelNode!
    var resetButton: SKLabelNode!
    var fillButton: SKLabelNode!
    var cubeButton: SKLabelNode!
    
    var sliderAxisX: SKShapeNode!
    var sliderAxisXlabel: SKLabelNode!
    var sliderAxisY: SKShapeNode!
    var sliderAxisYLabel: SKLabelNode!
    
    var tridimensionality: Bool = false
    var allowRotate: Bool = false
    var cubeMode: Bool = false
    
    var fillMode: MTLTriangleFillMode = .lines
    
    var auxiliar: String = ""
    
    var page: Int!
    
    public init(size: CGSize, fatherView: UIView, page: Int) {
        super.init(size: size)
        self.backgroundColor = UIColor.clear
        self.fatherView = fatherView
        self.page = page
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func didMove(to: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // configure all the nodes of the scene
        setNodes()
    }
    
    func setNodes() {
        // VertOne Declaration
        vertOne = SKShapeNode(circleOfRadius: 45)
        vertOne.fillColor = UIColor.red
        vertOne.strokeColor = UIColor.red
        vertOne.name = "vertOne"
        vertOne.alpha = 0.3
        vertOne.position = CGPoint(x: 0, y: 100)
        vertOne.isHidden = true
        addChild(vertOne)
        
        // VertTwo Declaration
        vertTwo = SKShapeNode(circleOfRadius: 45)
        vertTwo.fillColor = UIColor.blue
        vertTwo.strokeColor = UIColor.blue
        vertTwo.name = "vertTwo"
        vertTwo.alpha = 0.3
        vertTwo.position = CGPoint(x: 100, y: -50)
        vertTwo.isHidden = true
        addChild(vertTwo)
        
        // VertThree Declaration
        vertTree = SKShapeNode(circleOfRadius: 45)
        vertTree.fillColor = UIColor.green
        vertTree.strokeColor = UIColor.green
        vertTree.name = "vertTree"
        vertTree.alpha = 0.3
        vertTree.position = CGPoint(x: -100, y: -50)
        vertTree.isHidden = true
        addChild(vertTree)
        
        // vertFourth Declaration
        vertFourth = SKShapeNode(circleOfRadius: 45)
        vertFourth.fillColor = UIColor.white
        vertFourth.strokeColor = UIColor.white
        vertFourth.name = "vertFourth"
        vertFourth.alpha = 0.3
        vertFourth.position = CGPoint(x: 0, y: -20)
        vertFourth.isHidden = true
        addChild(vertFourth)
        
        // Button to allow 3D render, Declaration
        threeDButton = SKLabelNode(text: "3D: off")
        threeDButton.name = "3d"
        threeDButton.position = CGPoint(x: 160, y: 140)
        threeDButton.horizontalAlignmentMode = .center
        threeDButton.verticalAlignmentMode = .center
        threeDButton.isHidden = true
        addChild(threeDButton)
        
        // Button to allow rotation render, Declaration
        rotationButton = SKLabelNode(text: "Rotation: off")
        rotationButton.name = "rotation"
        rotationButton.position = CGPoint(x: 160, y: 100)
        rotationButton.horizontalAlignmentMode = .center
        rotationButton.verticalAlignmentMode = .center
        rotationButton.isHidden = true
        addChild(rotationButton)
        
        // Button to set the Fill mode
        fillButton = SKLabelNode(text: "FillMode: △")
        fillButton.name = "fillMode"
        fillButton.position = CGPoint(x: 160, y: 60)
        fillButton.horizontalAlignmentMode = .center
        fillButton.verticalAlignmentMode = .center
        fillButton.isHidden = true
        addChild(fillButton)
        
        // Button to changue de pyramyd to a Cube
        cubeButton = SKLabelNode(text: "Shape: △")
        cubeButton.name = "cube"
        cubeButton.position = CGPoint(x: 160, y: 60)
        cubeButton.horizontalAlignmentMode = .center
        cubeButton.verticalAlignmentMode = .center
        cubeButton.isHidden = true
        addChild(cubeButton)
        
        // Slider to control the Axis X
        sliderAxisX = SKShapeNode(circleOfRadius: 50)
        sliderAxisX.name = "sliderAxisX"
        sliderAxisX.alpha = 1.0
        sliderAxisX.position = CGPoint(x: 0, y: -120)
        sliderAxisX.isHidden = true
        addChild(sliderAxisX)
        
        sliderAxisXlabel = SKLabelNode(text: "X")
        sliderAxisXlabel.horizontalAlignmentMode = .center
        sliderAxisXlabel.verticalAlignmentMode = .center
        sliderAxisXlabel.isUserInteractionEnabled = true
        sliderAxisX.addChild(sliderAxisXlabel)
        
        // Slider to control the Axis Y
        sliderAxisY = SKShapeNode(circleOfRadius: 50)
        sliderAxisY.name = "sliderAxisY"
        sliderAxisY.alpha = 1.0
        sliderAxisY.position = CGPoint(x: 300, y: -120)
        sliderAxisY.isHidden = true
        addChild(sliderAxisY)
        
        sliderAxisYLabel = SKLabelNode(text: "Y")
        sliderAxisYLabel.horizontalAlignmentMode = .center
        sliderAxisYLabel.verticalAlignmentMode = .center
        sliderAxisYLabel.isUserInteractionEnabled = true
        sliderAxisY.addChild(sliderAxisYLabel)
        
        switch self.page {
        case 2:
            threeDButton.isHidden = false
            rotationButton.isHidden = false
            cubeButton.isHidden = false
            break
        case 3:
            vertOne.isHidden = false
            vertTwo.isHidden = false
            vertTree.isHidden = false
            sliderAxisX.isHidden = false
            sliderAxisY.isHidden = false
            threeDButton.isHidden = false
            rotationButton.isHidden = false
            fillButton.isHidden = false
            break
        default:
            break
        }
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                // pick up the node being touched
                // and sets the correct action for each node
                switch node.name {
                case threeDButton.name:
                    tridimensionality = tridimensionality ? false : true
                    vertFourth.isHidden = tridimensionality ? false : true
                    threeDButton.text = (threeDButton.text == "3D: off") ? "3D: on" : "3D: off"
                    sendData(model: catchData(cubeMode: self.cubeMode))
                    break
                case rotationButton.name:
                    allowRotate = allowRotate ? false : true
                    rotationButton.text = (rotationButton.text == "Rotation: off") ? "Rotation: on" : "Rotation: off"
                    sendData(model: catchData(cubeMode: self.cubeMode))
                    break
                case cubeButton.name:
                    threeDButton.isHidden = threeDButton.isHidden ? false : true
                    tridimensionality = false
                    vertFourth.isHidden = true
                    cubeMode = cubeMode ? false : true
                    cubeButton.text = (cubeButton.text == "Shape: △") ? "Shape: ❑" : " Shape: △"
                    sendData(model: catchData(cubeMode: self.cubeMode))
                    break
                case fillButton.name:
                    fillMode = (fillMode == .fill) ? .lines : .fill
                    fillButton.text = (fillButton.text == "FillMode: △") ? "FillMode: ▲" : "FillMode: △"
                    sendData(model: catchData(cubeMode: self.cubeMode))
                    break
                case sliderAxisX.name:
                    node.alpha = 0.3
                    auxiliar = node.name!
                    break
                case sliderAxisY.name:
                    node.alpha = 0.3
                    auxiliar = node.name!
                    break
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
            // takes the vertex nodes and changes their position with respect to the touch
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                switch node.name {
                case auxiliar:
                    if (node.name == sliderAxisX.name) {
                        node.position.x = location.x
                        break
                    } else if (node.name == sliderAxisY.name){
                        node.position.y = location.y
                        break
                    }
                    node.position = location
                    break
                default:
                    break
                    
                }
                // send the position
                sendData(model: catchData(cubeMode: self.cubeMode))
            }
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // ensures that the nodes are deselected
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            for node in nodes {
                switch node.name {
                case threeDButton.name:
                    break
                case rotationButton.name:
                    break
                case cubeButton.name:
                    break
                case fillButton.name:
                    break
                default:
                    node.alpha = (node.alpha == 1.0) ? 0.3 : 1.0
                    auxiliar = ""
                    break
                }
            }
        }
    }
    
    func catchData(cubeMode: Bool) -> ModelData {
        // pick up the nodes position and return a vector of vectors of four floats
        
        if (!tridimensionality && !cubeMode) {
            let triangleVertex = [
                                Vertex(pos: [Float(vertOne.position.x / (self.view!.frame.width)/0.1), Float(vertOne.position.y / (self.view!.frame.height/7)), 0.0, 1.0],
                                col: Color.red),
                                 Vertex(pos: [Float(vertTwo.position.x / (self.view!.frame.width)/0.1), Float(vertTwo.position.y / (self.view!.frame.height/7)), 0.0, 1.0],
                                col: Color.blue),
                                 Vertex(pos: [Float(vertTree.position.x / (self.view!.frame.width)/0.1), Float(vertTree.position.y / (self.view!.frame.height/7)), -2.0, 1.0],
                                col: Color.green)]
            let triangleIndex: [UInt16] = [0, 1, 2]
            return ModelData(verteces: triangleVertex, indices: triangleIndex)
            
        } else if cubeMode {
            let cubeVertex = [
                Vertex(pos: [-1.0, -1.0,  1.0, 1.0], col: Color.red),
                Vertex(pos: [ 1.0, -1.0,  1.0, 1.0], col: Color.blue),
                Vertex(pos: [ 1.0,  1.0,  1.0, 1.0], col: Color.green),
                Vertex(pos: [-1.0,  1.0,  1.0, 1.0], col: Color.white),
                Vertex(pos: [-1.0, -1.0, -1.0, 1.0], col: Color.red),
                Vertex(pos: [ 1.0, -1.0, -1.0, 1.0], col: Color.blue),
                Vertex(pos: [ 1.0,  1.0, -1.0, 1.0], col: Color.green),
                Vertex(pos: [-1.0,  1.0, -1.0, 1.0], col: Color.white)]
            let cubeIndex: [UInt16] = [0, 1, 2, 2, 3, 0,   // front
                                       1, 5, 6, 6, 2, 1,   // right
                                       3, 2, 6, 6, 7, 3,   // top
                                       4, 5, 1, 1, 0, 4,   // bottom
                                       4, 0, 3, 3, 7, 4,   // left
                                       7, 6, 5, 5, 4, 7]   // back
            return ModelData(verteces: cubeVertex, indices: cubeIndex)
            
        } else {
            let pyramidVertex: [Vertex] = [
                        Vertex(pos: [Float(vertOne.position.x / (self.view!.frame.width)/0.1), Float(vertOne.position.y / (self.view!.frame.height/7)), 0.0, 1.0],
                               col: Color.red),
                        Vertex(pos: [Float(vertTwo.position.x / (self.view!.frame.width)/0.1), Float(vertTwo.position.y / (self.view!.frame.height/7)), 0.0, 1.0],
                               col: Color.blue),
                        Vertex(pos: [Float(vertTree.position.x / (self.view!.frame.width)/0.1), Float(vertTree.position.y / (self.view!.frame.height/7)), -2.0, 1.0],
                               col: Color.green),
                        Vertex(pos: [0.0 , Float(vertFourth.position.y / (self.view!.frame.height/7)), Float(vertFourth.position.x / (self.view!.frame.width)/0.1), 1.0],
                               col: Color.white)]
            
            let pyramdIndex: [UInt16] = [0, 1, 2,
                                         0, 1, 3,
                                         0, 2, 3,
                                         1, 2, 3]
            return ModelData(verteces: pyramidVertex, indices: pyramdIndex)
        }
    }
    
    func sendData(model: ModelData){
        // sets the VertexData and IndexData to send it to the MTKView Delegate\
        
        for view in self.fatherView.subviews {
            guard let mtkView = view as? MTKView else {
                return
            }
            guard let delegate = mtkView.delegate as? Renderer else {
                return
            }
            // sends the necessary information
            delegate.setTriangleFillMode(fillMode: self.fillMode)
            delegate.setCameraPosition(camPos: vector_float3(x: Float(sliderAxisX.position.x / (self.view!.frame.width/10)),
                                                             y: Float(sliderAxisY.position.y / (self.view!.frame.height/10)),
                                                             z: 5))
            delegate.updateForm(vertexData: model.vertexData,
                                indexData: model.indexData,
                                tridimensionality: self.tridimensionality,
                                allowRotate: self.allowRotate)
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        self.scene?.size = CGSize(width: self.view!.frame.width * 2, height: self.view!.frame.height * 2)
    }
}
