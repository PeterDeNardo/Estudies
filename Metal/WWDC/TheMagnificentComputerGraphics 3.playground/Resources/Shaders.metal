#include <metal_stdlib>
using namespace metal;
//Define the vertex struct
struct Vertex {
    float4 position [[position]];
    float4 color;
};
//Define VertexUniforms with de model matrix
struct VertexUniforms {
    float4x4 modelMatrix;
};


vertex Vertex vertex_func(constant Vertex *vertices [[buffer(0)]],
                          constant VertexUniforms &uniforms [[buffer(1)]],
                          uint vid [[vertex_id]]) {
    //gets the constants variables and
    float4x4 matrix = uniforms.modelMatrix;
    Vertex in = vertices[vid];
    Vertex out;
    out.position = matrix * float4(in.position);
    out.color = in.color;
    return out;
}

fragment float4 fragment_func(Vertex vert [[stage_in]]) {
    //colorizes the pixels between the vertices
    return vert.color;
}


