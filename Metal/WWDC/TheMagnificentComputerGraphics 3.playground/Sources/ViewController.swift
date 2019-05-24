import UIKit
import MetalKit
import SpriteKit
import PlaygroundSupport

public class ViewController: UIViewController {
    var mtkView: MTKView!
    var skView: SKView!
    var renderer: Renderer!
    var allowsRotate: Bool = false
    var vertexData: [Vertex]!
    var indexData: [UInt16]!
    var page: Int!
    static var shared = self
    
    public init(vertexData: [Vertex], indexData: [UInt16], page: Int){
        self.vertexData = vertexData
        self.indexData = indexData
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.width))
        self.view = view
        configSubViews()
        
    }
    
    func configSubViews() {
        // Configure MTKView
        mtkView = MTKView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height))
        mtkView.translatesAutoresizingMaskIntoConstraints = false
        let device = MTLCreateSystemDefaultDevice()!
        mtkView.device = device
        renderer = Renderer(view: mtkView,
                            device: mtkView.device!,
                            allowsRotate: self.allowsRotate,
                            vertexData: self.vertexData,
                            indexData: self.indexData)
        
        mtkView.delegate = renderer
        mtkView.draw(CGRect(x: 0,
                            y: 0,
                            width: self.view.frame.width,
                            height: self.view.frame.height))
        self.view.addSubview(mtkView)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[mtkView]|",
                                                                options: [],
                                                                metrics: nil, views: ["mtkView" : mtkView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mtkView]|",
                                                                options: [],
                                                                metrics: nil, views: ["mtkView" : mtkView]))
        
        
        // Configure SKView
        self.skView = SKView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                           size: CGSize(width: self.view.bounds.width,
                                                        height: self.view.bounds.height)))
        self.skView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.skView.backgroundColor = UIColor.clear
        self.skView.allowsTransparency = true
        self.skView.ignoresSiblingOrder = true
        self.skView.showsFPS = true
        self.skView.showsNodeCount = true
        self.skView.translatesAutoresizingMaskIntoConstraints = false
        let scene = GameScene(size: self.view.frame.size, fatherView: self.view, page: self.page)
        scene.scaleMode = .aspectFill
        self.skView.presentScene(scene)
        self.view.addSubview(skView)
    }
}



