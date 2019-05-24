
import simd

public struct Vertex {
    var position: vector_float4
    var color: vector_float4
    public init(pos: vector_float4, col: Color) {
        position = pos
        color = col.rawValue
    }
}

public struct Uniforms {
    var modelViewProjectionMatrix: matrix_float4x4
    public init(model: matrix_float4x4) {
        modelViewProjectionMatrix = model;
    }
}

public func translationMatrix(position: float3) -> matrix_float4x4 {
    let X = vector_float4(1, 0, 0, 0)
    let Y = vector_float4(0, 1, 0, 0)
    let Z = vector_float4(0, 0, 1, 0)
    let W = vector_float4(position.x, position.y, position.z, 1)
    return matrix_float4x4(columns:(X, Y, Z, W))
}

public func scalingMatrix(scale: Float) -> matrix_float4x4 {
    let X = vector_float4(scale, 0, 0, 0)
    let Y = vector_float4(0, scale, 0, 0)
    let Z = vector_float4(0, 0, scale, 0)
    let W = vector_float4(0, 0, 0, 1)
    return matrix_float4x4(columns:(X, Y, Z, W))
}

public func rotationMatrix(angle: Float, axis: vector_float3) -> matrix_float4x4 {
    var X = vector_float4(0, 0, 0, 0)
    X.x = axis.x * axis.x + (1 - axis.x * axis.x) * cos(angle)
    X.y = axis.x * axis.y * (1 - cos(angle)) - axis.z * sin(angle)
    X.z = axis.x * axis.z * (1 - cos(angle)) + axis.y * sin(angle)
    X.w = 0.0
    var Y = vector_float4(0, 0, 0, 0)
    Y.x = axis.x * axis.y * (1 - cos(angle)) + axis.z * sin(angle)
    Y.y = axis.y * axis.y + (1 - axis.y * axis.y) * cos(angle)
    Y.z = axis.y * axis.z * (1 - cos(angle)) - axis.x * sin(angle)
    Y.w = 0.0
    var Z = vector_float4(0, 0, 0, 0)
    Z.x = axis.x * axis.z * (1 - cos(angle)) - axis.y * sin(angle)
    Z.y = axis.y * axis.z * (1 - cos(angle)) + axis.x * sin(angle)
    Z.z = axis.z * axis.z + (1 - axis.z * axis.z) * cos(angle)
    Z.w = 0.0
    let W = vector_float4(0, 0, 0, 1)
    return matrix_float4x4(columns:(X, Y, Z, W))
}

public func projectionMatrix(near: Float, far: Float, aspect: Float, fovy: Float) -> matrix_float4x4 {
    let scaleY = 1 / tan(fovy * 0.5)
    let scaleX = scaleY / aspect
    let scaleZ = -(far + near) / (far - near)
    let scaleW = -2 * far * near / (far - near)
    let X = vector_float4(scaleX, 0, 0, 0)
    let Y = vector_float4(0, scaleY, 0, 0)
    let Z = vector_float4(0, 0, scaleZ, -1)
    let W = vector_float4(0, 0, scaleW, 0)
    return matrix_float4x4(columns:(X, Y, Z, W))
}




//
//import MetalKit
//
//public class MetalDelegate: NSObject, MTKViewDelegate {
//
//    public var device: MTLDevice!
//    var queue: MTLCommandQueue!
//    var vertexBuffer: MTLBuffer!
//    var uniformBuffer: MTLBuffer!
//    var indexBuffer: MTLBuffer!
//    var rps: MTLRenderPipelineState!
//    var rotation: Float = 0
//
//    override public init() {
//        super.init()
//        device = MTLCreateSystemDefaultDevice()
//        queue = device.makeCommandQueue()
//        createBuffers()
//        createPipeline()
//    }
//
//    func createBuffers() {
//        let vertexData = [
//            Vertex(pos: [-1.0, -1.0,  1.0, 1.0], col: [1, 1, 1, 1]),
//            Vertex(pos: [ 1.0, -1.0,  1.0, 1.0], col: [1, 0, 0, 1]),
//            Vertex(pos: [ 1.0,  1.0,  1.0, 1.0], col: [1, 1, 0, 1]),
//            Vertex(pos: [-1.0,  1.0,  1.0, 1.0], col: [0, 1, 0, 1]),
//            Vertex(pos: [-1.0, -1.0, -1.0, 1.0], col: [0, 0, 1, 1]),
//            Vertex(pos: [ 1.0, -1.0, -1.0, 1.0], col: [1, 0, 1, 1]),
//            Vertex(pos: [ 1.0,  1.0, -1.0, 1.0], col: [0, 0, 0, 1]),
//            Vertex(pos: [-1.0,  1.0, -1.0, 1.0], col: [0, 1, 1, 1])]
//
//        let indexData: [UInt16] = [
//            0, 1, 2, 2, 3, 0,   // front
//            1, 5, 6, 6, 2, 1,   // right
//            3, 2, 6, 6, 7, 3,   // top
//            4, 5, 1, 1, 0, 4,   // bottom
//            4, 0, 3, 3, 7, 4,   // left
//            7, 6, 5, 5, 4, 7]   // back
//
//        vertexBuffer = device!.makeBuffer(bytes: vertexData, length: MemoryLayout<Vertex>.size * vertexData.count, options: [])
//        indexBuffer = device!.makeBuffer(bytes: indexData, length: MemoryLayout<UInt16>.size * indexData.count , options: [])
//        uniformBuffer = device!.makeBuffer(length: MemoryLayout<matrix_float4x4>.size, options: [])
//    }
//
//    func createPipeline() {
//        let path = Bundle.main.path(forResource: "Shaders", ofType: "metal")
//        let input: String?
//        let library: MTLLibrary
//        let vert_func: MTLFunction
//        let frag_func: MTLFunction
//        do {
//            input = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
//            library = try device!.makeLibrary(source: input!, options: nil)
//            vert_func = library.makeFunction(name: "vertex_func")!
//            frag_func = library.makeFunction(name: "fragment_func")!
//            let rpld = MTLRenderPipelineDescriptor()
//            rpld.vertexFunction = vert_func
//            rpld.fragmentFunction = frag_func
//            rpld.colorAttachments[0].pixelFormat = .bgra8Unorm
//            rps = try device!.makeRenderPipelineState(descriptor: rpld)
//        } catch let e {
//            Swift.print("\(e)")
//        }
//    }
//
//    func update() {
//        let scaled = scalingMatrix(scale: 0.5)
//        rotation += 1 / 100 * Float.pi / 4
//        let rotatedY = rotationMatrix(angle: rotation, axis: float3(0, 1, 0))
//        let rotatedX = rotationMatrix(angle: Float.pi / 4, axis: float3(1, 0, 0))
//        let modelMatrix = matrix_multiply(matrix_multiply(rotatedX, rotatedY), scaled)
//        let cameraPosition = vector_float3(0, 0, -3)
//        let viewMatrix = translationMatrix(position: cameraPosition)
//        let projMatrix = projectionMatrix(near: 0, far: 10, aspect: 1, fovy: 1)
//        let modelViewProjectionMatrix = matrix_multiply(projMatrix, matrix_multiply(viewMatrix, modelMatrix))
//        let bufferPointer = uniformBuffer.contents()
//        var uniforms = Uniforms(model: modelViewProjectionMatrix)
//        memcpy(bufferPointer, &uniforms, MemoryLayout<Uniforms>.size)
//    }
//
//    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
//
//    public func draw(in view: MTKView) {
//        update()
//        if let rpd = view.currentRenderPassDescriptor,
//            let drawable = view.currentDrawable,
//            let commandBuffer = queue.makeCommandBuffer(),
//            let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: rpd) {
//            rpd.colorAttachments[0].clearColor = MTLClearColorMake(0.5, 0.5, 0.5, 1.0)
//            commandEncoder.setTriangleFillMode(.lines)
//            commandEncoder.setRenderPipelineState(rps)
//            commandEncoder.setFrontFacing(.counterClockwise)
//            commandEncoder.setCullMode(.back)
//            commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
//            commandEncoder.setVertexBuffer(uniformBuffer, offset: 0, index: 1)
//            commandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indexBuffer.length / MemoryLayout<UInt16>.size, indexType: MTLIndexType.uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
//            commandEncoder.endEncoding()
//            commandBuffer.present(drawable)
//            commandBuffer.commit()
//        }
//    }
//}
//
//

