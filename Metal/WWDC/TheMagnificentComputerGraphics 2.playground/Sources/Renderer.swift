import Foundation
import MetalKit
import SpriteKit
import simd

protocol MTKCustomDelegate : MTKViewDelegate{
    //create a custom MTKViewDelegate for make custom fuctions
    func updateForm (vertexData: [Vertex], indexData: [UInt16], tridimensionality: Bool, allowRotate: Bool)
    func setCameraPosition (camPos: vector_float3)
    func setTriangleFillMode (fillMode: MTLTriangleFillMode)
}

class Renderer: NSObject, MTKCustomDelegate {
    var mtkView: MTKView!
    var device: MTLDevice!
    var queue: MTLCommandQueue!
    var vertexBuffer: MTLBuffer!
    var vertexUniformsBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var rps: MTLRenderPipelineState!
    var rotation: Float = 0
    var initialPos: Float = 0
    var allowsRotate: Bool = false
    var tridimensionality: Bool = false
    var camPos: vector_float3 = [0, 0, 5]
    var fillMode: MTLTriangleFillMode = .lines
    
    init(view: MTKView, device: MTLDevice, allowsRotate: Bool, vertexData: [Vertex], indexData: [UInt16]) {
        // set MTKView and currect device
        self.mtkView = view
        self.device = device
        self.queue = self.device.makeCommandQueue()
        self.allowsRotate = allowsRotate
        super.init()
        
        createBuffers(vertexData: vertexData, indexData: indexData)
        createPipeline()
    }

    public func createBuffers(vertexData: [Vertex], indexData: [UInt16]) {
        // makes the vertex and index Buffers
        vertexBuffer = device!.makeBuffer(bytes: vertexData, length: MemoryLayout<Vertex>.size * vertexData.count, options: [])
        indexBuffer = device!.makeBuffer(bytes: indexData, length: MemoryLayout<UInt16>.size * indexData.count , options: [])
        vertexUniformsBuffer = device!.makeBuffer(length: MemoryLayout<matrix_float4x4>.size, options: [])
    }
    
    func createPipeline() {
        // Connects the code to the .metal responsible for rendering the shaders and framents
        let path = Bundle.main.path(forResource: "Shaders", ofType: "metal")
        let input: String?
        let library: MTLLibrary
        let vert_func: MTLFunction
        let frag_func: MTLFunction
        do {
            input = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            library = try device!.makeLibrary(source: input!, options: nil)
            vert_func = library.makeFunction(name: "vertex_func")!
            frag_func = library.makeFunction(name: "fragment_func")!
            let rpld = MTLRenderPipelineDescriptor()
            rpld.vertexFunction = vert_func
            rpld.fragmentFunction = frag_func
            rpld.colorAttachments[0].pixelFormat = .bgra8Unorm
            rps = try device!.makeRenderPipelineState(descriptor: rpld)
        } catch let e {
            Swift.print("\(e)")
        }
    }
    
    func update() {
        // creates the scene configurations and the animations
        // FIRST-BLOCK
        // sets the rotation of the object on modelMatrix
        let axisY: float3 = float3(1,0,0)
        let axisX: float3 = float3(0,1,0)
        let scaled = scalingMatrix(scale: 0.5)
        if allowsRotate {
            rotation += 1 / 100 * Float.pi / 4
            initialPos = Float.pi / 4
        }
        let rotatedY = rotationMatrix(angle: rotation, axis: axisY)
        let rotatedX = rotationMatrix(angle: initialPos, axis: axisX)
        let modelMatrix = matrix_multiply(matrix_multiply(rotatedX, rotatedY), scaled)
        // SECOND-BLOCK
        // sets camera on viewMatrix and create porjectionmMatrix
        let cameraPosition = camPos
        
        let viewMatrix = GLKMatrix4MakeLookAt(cameraPosition.x, cameraPosition.y, cameraPosition.z,
                                              0.0, 0.0, 0.0,
                                              0.0, 1.0, 0.0)
        let projMatrix = projectionMatrix(near: 0, far: 10, aspect: 1, fovy: 1)
        // THIRD BLOCK
        // multiply projectionMatrix with the result of viewMatrinx with modelMatrix
        // to copy the result to vertexUnifromBuffer
        // with the memcpy
        let modelViewProjectionMatrix = matrix_multiply(projMatrix, matrix_multiply(float4x4(matrix: viewMatrix), modelMatrix))
        let bufferPointer = vertexUniformsBuffer.contents()
        var uniforms = Uniforms(model: modelViewProjectionMatrix)
        memcpy(bufferPointer, &uniforms, MemoryLayout<Uniforms>.size)
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    public func updateForm(vertexData: [Vertex],
                           indexData: [UInt16],
                           tridimensionality: Bool,
                           allowRotate: Bool) {
        // recreate the buffers with the new position
        createBuffers(vertexData: vertexData, indexData: indexData)
        // sets whether the object will be rotated
        self.tridimensionality = tridimensionality
        self.allowsRotate = allowRotate
        
    }
    
    func setCameraPosition(camPos: vector_float3) {
        // update the camera position
        self.camPos = camPos
    }
    
    func setTriangleFillMode(fillMode: MTLTriangleFillMode) {
        // update the fill configurate
        self.fillMode = fillMode
    }
    
    public func draw(in view: MTKView) {
        // in case of rotate update the scene
        update()
        // draw the vertices and fragments with the help of .metal
        if let rpd = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable,
            let commandBuffer = queue.makeCommandBuffer(),
            let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: rpd) {
            rpd.colorAttachments[0].clearColor = MTLClearColorMake(0.5, 0.5, 0.5, 1.0)
            // configure how will fill the triangles
            commandEncoder.setTriangleFillMode(fillMode)
            commandEncoder.setRenderPipelineState(rps)
            commandEncoder.setFrontFacing(.counterClockwise)
            // configure how will render the verteces
            commandEncoder.setCullMode(.none)
            // get the VertexBuffer
            commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            // get the UniformBuffer
            commandEncoder.setVertexBuffer(vertexUniformsBuffer, offset: 0, index: 1)
            // draw
            commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indexBuffer.length / MemoryLayout<UInt16>.size, indexType: MTLIndexType.uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
            commandEncoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}








