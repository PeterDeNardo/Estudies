//: [Previous](@previous)

/*:
 # Ow What is Computer Graphics?
 
 Recently I started to study in my college this large area of ​​computer science and while I was lost in this huge amount of content I made my first question as clear and objective as possible, what is CG? We can respond in many different ways to this question but in a nutshell, Computer Graphics is about almost everything that does not involve sound or text on a computer more specifically when we treat images and visual models on the computer.
 
 In this playgrounds I want to try as much as possible to explain some simple concepts of this area that I know so little but already I had immensely.
 
 I will avoid delving into very deep mathematical concepts because I do not master them, STILL💪💪💪 !!! And I also want to keep the content as playful as possible in a pleasant and delicious way
 
 on this page I'll cover about
 * Vertex
 * 3D
 
 First, Vertex in nerd language is a data structure, we use them to locate the position of our representations in 2D or 3D on the screen, for normal people, Vertex are small and beautiful points that together we use to construct 2D or 3D shapes
 
 */
import MetalKit
//#-hidden-code
import PlaygroundSupport

public class MetalView: MTKView {
    
    var vertexData: [Vertex] = []
    
    public override init(frame frameRect: CGRect, device: MTLDevice?){
        super.init(frame: frameRect, device: device)
        self.frame = frame
        self.device = device
        self.delegate = delegate
        let image = NSImage(named: "background")
        let imageView = NSImageView(frame: self.frame)
        imageView.image = image
        imageView.alphaValue = 0.8
        self.addSubview(imageView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override public func mouseDown(with event: NSEvent) {
    //        var location = self.convert(event.locationInWindow, from: nil)
    //        location.y = self.bounds.height - location.y
    //
    //        var canvasPosX: Float
    //        var canvasPosY: Float
    //
    //        if location.x < 200 {
    //            canvasPosX = Float((location.x / 200) - 1)
    //        } else {
    //            canvasPosX = Float((location.x / 200) - 1)
    //        }
    //        if location.y < 200 {
    //            canvasPosY = Float((location.y / 200) - 1)
    //        } else {
    //            canvasPosY = Float((location.y / 200) - 1)
    //        }
    //
    //        canvasPosX = (canvasPosX * 10).rounded() / 10
    //        canvasPosY = (canvasPosY * 10).rounded() / 10
    //
    //        if vertexData.count >= 3 {
    //            let indexData: [UInt16] = [0,1,2]
    //
    //        } else {
    //            vertexData.append(Vertex(pos: [canvasPosX, canvasPosY, 0, 1], col: [0,0,0,1]))
    //        }
    //    }
}
//#-end-hidden-code

//#-editable-code
let vertexData = [
    Vertex(pos: [-2.0, -1.0, 0.0, 1.0], col: Color.green),
    Vertex(pos: [ 3.0, -1.0, 0.0, 1.0], col: Color.red),
    Vertex(pos: [ -2.0, 3.0, 0.0, 1.0], col: Color.blue),
    Vertex(pos: [ 2.0, 3.0, 0.0, 1.0], col: Color.green)]

let allowsRotate = false
//#-end-editable-code

//#-hidden-code
let frame = NSRect(x: 0, y: 0, width: 400, height: 400)
let delegate = MetalDelegate(vertexData: vertexData, allowsRotate: allowsRotate)
let view = MetalView(frame: frame, device: delegate.device)
view.delegate = delegate
PlaygroundPage.current.liveView = view
//#-end-hidden-code


//: [Next](@next)
