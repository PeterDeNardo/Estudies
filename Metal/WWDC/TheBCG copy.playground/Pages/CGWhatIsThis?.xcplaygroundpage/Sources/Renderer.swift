import Foundation
import MetalKit
import SpriteKit
import simd

protocol MTKCustomDelegate : MTKViewDelegate{
    func updateForm (vertexData: [Vertex], indexData: [UInt16], tridimensionality: Bool, allowRotate: Bool, allowReset: Bool)
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
    
    init(view: MTKView, device: MTLDevice, allowsRotate: Bool, vertexData: [Vertex], indexData: [UInt16]) {
        self.mtkView = view
        self.device = device
        self.allowsRotate = allowsRotate
        queue = device.makeCommandQueue()
        super.init()
        
        createBuffers(vertexData: vertexData, indexData: indexData)
        createPipeline()
        
    }

    public func createBuffers(vertexData: [Vertex], indexData: [UInt16]) {
        vertexBuffer = device!.makeBuffer(bytes: vertexData, length: MemoryLayout<Vertex>.size * vertexData.count, options: [])
        indexBuffer = device!.makeBuffer(bytes: indexData, length: MemoryLayout<UInt16>.size * indexData.count , options: [])
        vertexUniformsBuffer = device!.makeBuffer(length: MemoryLayout<matrix_float4x4>.size, options: [])
    }
    
    func createPipeline() {
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
        let axisY: float3!
        let axisX: float3!
        let scaled = scalingMatrix(scale: 0.5)
        if allowsRotate {
            rotation += 1 / 100 * Float.pi / 4
            initialPos = Float.pi / 4
        } 
    
        axisX = float3(1,0,0)
        axisY = float3(0,1,0)
        
        let rotatedY = rotationMatrix(angle: rotation, axis: axisY)
        let rotatedX = rotationMatrix(angle: initialPos, axis: axisX)
        let modelMatrix = matrix_multiply(matrix_multiply(rotatedX, rotatedY), scaled)
        let cameraPosition = vector_float3(0, 0, 6)
        let viewMatrix = (translationMatrix(position: cameraPosition) * rotationMatrix(angle: initialPos, axis: axisY))
        let projMatrix = projectionMatrix(near: 0, far: 10, aspect: 1, fovy: 1)
        let modelViewProjectionMatrix = matrix_multiply(projMatrix, matrix_multiply(viewMatrix, modelMatrix))
        let bufferPointer = vertexUniformsBuffer.contents()
        var uniforms = Uniforms(model: modelViewProjectionMatrix)
        memcpy(bufferPointer, &uniforms, MemoryLayout<Uniforms>.size)
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    public func updateForm(vertexData: [Vertex],
                           indexData: [UInt16],
                           tridimensionality: Bool,
                           allowRotate: Bool,
                           allowReset: Bool) {
        
        createBuffers(vertexData: vertexData, indexData: indexData)
        self.tridimensionality = tridimensionality
        self.allowsRotate = allowRotate
        
    }
    
    public func draw(in view: MTKView) {
        update()
        if let rpd = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable,
            let commandBuffer = queue.makeCommandBuffer(),
            let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: rpd) {
            rpd.colorAttachments[0].clearColor = MTLClearColorMake(0.5, 0.5, 0.5, 1.0)
            commandEncoder.setTriangleFillMode(.lines)
            commandEncoder.setRenderPipelineState(rps)
            commandEncoder.setFrontFacing(.counterClockwise)
            commandEncoder.setCullMode(.none)
            commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            commandEncoder.setVertexBuffer(vertexUniformsBuffer, offset: 0, index: 1)
            commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indexBuffer.length / MemoryLayout<UInt16>.size, indexType: MTLIndexType.uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
            commandEncoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}








