
import simd

public struct modelData {
    public var vertexData: [Vertex]
    public var indexData: [UInt16]
    public init(verteces: [Vertex], indices: [UInt16]) {
        self.vertexData = verteces;
        self.indexData = indices
    }
}

public enum Color {
    case white
    case black
    case blue
    case green
    case red
}

extension Color: RawRepresentable{
    public typealias RawValue = vector_float4
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case [1, 1, 1, 1]: self = .white
        case [0, 0, 0, 1]: self = .black
        case [0, 0, 1, 1]: self = .blue
        case [0, 1, 0, 1]: self = .green
        case [1, 0, 0, 1]: self = .red
        default: return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .white: return [1, 1, 1, 1]
        case .black: return [0, 0, 0, 1]
        case .blue: return [0, 0, 1, 1]
        case .green: return [0, 1, 0, 1]
        case .red: return [1, 0, 0, 1]
        }
    }
}

public func makeCube() -> modelData {
    let cubeVertex = [
        Vertex(pos: [-1.0, -1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0, -1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0,  1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [-1.0,  1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [-1.0, -1.0, -1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0, -1.0, -1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0,  1.0, -1.0, 1.0], col: Color.white),
        Vertex(pos: [-1.0,  1.0, -1.0, 1.0], col: Color.white)]
    
    let cubeIndex: [UInt16] = [
        0, 1, 2, 2, 3, 0,   // front
        1, 5, 6, 6, 2, 1,   // right
        3, 2, 6, 6, 7, 3,   // top
        4, 5, 1, 1, 0, 4,   // bottom
        4, 0, 3, 3, 7, 4,   // left
        7, 6, 5, 5, 4, 7]   // back
    
    let cube = modelData(verteces: cubeVertex, indices: cubeIndex)
    
    return cube
}

public func makeCube2() -> modelData {
    let cubeVertex = [
        Vertex(pos: [-3.0, -1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0, -1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0,  1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [-1.0,  1.0,  1.0, 1.0], col: Color.white),
        Vertex(pos: [-1.0, -1.0, -1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0, -1.0, -1.0, 1.0], col: Color.white),
        Vertex(pos: [ 1.0,  2.0, -1.0, 1.0], col: Color.white),
        Vertex(pos: [-1.0,  1.0, -1.0, 1.0], col: Color.white)]
    
    let cubeIndex: [UInt16] = [
        0, 1, 2, 2, 3, 0,   // front
        1, 5, 6, 6, 2, 1,   // right
        3, 2, 6, 6, 7, 3,   // top
        4, 5, 1, 1, 0, 4,   // bottom
        4, 0, 3, 3, 7, 4,   // left
        7, 6, 5, 5, 4, 7]   // back
    
    let cube = modelData(verteces: cubeVertex, indices: cubeIndex)
    
    return cube
}
