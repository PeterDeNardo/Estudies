
import simd
import GLKit

// Model that unifies the vertex array with its respective indexes
public struct ModelData {
    public var vertexData: [Vertex]
    public var indexData: [UInt16]
    public init(verteces: [Vertex], indices: [UInt16]) {
        self.vertexData = verteces;
        self.indexData = indices
    }
}

// Help with vertex color definition
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

// Extension thats allow me to transfrom a GLKMatrix4 on a simd Float4x4
extension float4x4 {
    init(matrix: GLKMatrix4) {
        self.init(columns: (float4(x: matrix.m00, y: matrix.m01, z: matrix.m02, w: matrix.m03),
                            float4(x: matrix.m10, y: matrix.m11, z: matrix.m12, w: matrix.m13),
                            float4(x: matrix.m20, y: matrix.m21, z: matrix.m22, w: matrix.m23),
                            float4(x: matrix.m30, y: matrix.m31, z: matrix.m32, w: matrix.m33)))
    }
}


