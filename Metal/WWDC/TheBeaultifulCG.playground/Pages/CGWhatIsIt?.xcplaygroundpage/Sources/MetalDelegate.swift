
import MetalKit

public class MetalDelegate: NSObject, MTKViewDelegate {
    
    public var device: MTLDevice!
    var queue: MTLCommandQueue!
    var vertexBuffer: MTLBuffer!
    var uniformBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var rps: MTLRenderPipelineState!
    var rotation: Float = 0
    var initialPos: Float = 0
    var allowsRotate: Bool = false
    
    public init(vertexData: [Vertex], allowsRotate: Bool) {
        super.init()
        device = MTLCreateSystemDefaultDevice()
        queue = device.makeCommandQueue()
        
        createBuffers(vertexData: vertexData)
        createPipeline()
        
        self.allowsRotate = allowsRotate
    }
    
    public func createBuffers(vertexData: [Vertex]) {
        let indexData: [UInt16] =
            [0, 1, 2, 2, 1, 3]
        
        vertexBuffer = device!.makeBuffer(bytes: vertexData, length: MemoryLayout<Vertex>.size * vertexData.count, options: [])
        indexBuffer = device!.makeBuffer(bytes: indexData, length: MemoryLayout<UInt16>.size * indexData.count , options: [])
        uniformBuffer = device!.makeBuffer(length: MemoryLayout<matrix_float4x4>.size, options: [])
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
        let scaled = scalingMatrix(scale: 0.5)
        if allowsRotate {
            rotation += 1 / 100 * Float.pi / 4
            initialPos = Float.pi / 4
        }
        let rotatedY = rotationMatrix(angle: rotation, axis: float3(0, 0, 1))
        let rotatedX = rotationMatrix(angle: initialPos, axis: float3(0, 1, 0))
        let modelMatrix = matrix_multiply(matrix_multiply(rotatedX, rotatedY), scaled)
        let cameraPosition = vector_float3(0, 0, -3)
        let viewMatrix = translationMatrix(position: cameraPosition)
        let projMatrix = projectionMatrix(near: 0, far: 10, aspect: 1, fovy: 1)
        let modelViewProjectionMatrix = matrix_multiply(projMatrix, matrix_multiply(viewMatrix, modelMatrix))
        let bufferPointer = uniformBuffer.contents()
        var uniforms = Uniforms(model: modelViewProjectionMatrix)
        memcpy(bufferPointer, &uniforms, MemoryLayout<Uniforms>.size)
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
    
    public func draw(in view: MTKView) {
        update()
        if let rpd = view.currentRenderPassDescriptor,
            let drawable = view.currentDrawable,
            let commandBuffer = queue.makeCommandBuffer(),
            let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: rpd) {
            rpd.colorAttachments[0].clearColor = MTLClearColorMake(0.5, 0.5, 0.5, 1.0)
            //commandEncoder.setTriangleFillMode(.lines)
            commandEncoder.setRenderPipelineState(rps)
            commandEncoder.setFrontFacing(.counterClockwise)
            commandEncoder.setCullMode(.back)
            commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
            commandEncoder.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
            commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indexBuffer.length / MemoryLayout<UInt16>.size, indexType: MTLIndexType.uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
            commandEncoder.endEncoding()
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}



