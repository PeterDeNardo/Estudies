//: [Previous](@previous)
//#-hidden-code
import PlaygroundSupport
//#-end-hidden-code
/*:
 # The Myth of 3D 😱 and TRIANGLES ◢◣
 
 In this Page we will
 * Made a Pyramid of three faces
 * Understand 3D
 * And see the importance of TRIANGLES ⚠️🔺!!!
 
 FIRST: Good news, to make life easier, now let's use only the buttons on the screen
 
 Before we build our pyramid we have to understand about 3D, FIRST, 3D does not exist. Yes, it is difficult to accept at the beginning, but all we see with perspective and depth is nothing more than Computational Magic. The CPU and mainly the GPU render images in a way that we have the impression of seeing something in 3D, and behind the magic are layers and layers of Analysis Geometry and Linear Algebra, or Matrices and More Matrices.
 
 All right, let's do something, first to make a three-sided pyramid, we need one more vertex
 
    Vertex Data = [
                Vertex(pos: [-2.0, -1.0, 0.0, 1.0],
                       col: Color.green),
                Vertex(pos: [ 2.0, -1.0, 0.0, 1.0],
                       col: Color.blue),
                Vertex(pos: [ 0.0,  3.0, 0.0, 1.0],
                       col: Color.red),
                Vertex(pos: [ 0.0, -1.0, 4.0, 1.0],
                       col: Color.white)]
 
And new connections in our indexArray to form more faces, it is important to connect the correct vertices to form the desired figure
 
    indexData = [0, 1, 2, // FRONT
                 0, 1, 3, // LEFT
                 0, 2, 3, // RIGTH
                 1, 2, 3] // BOTTOM

 And on the triangles, if Vertex is our base, they are our material, all the shapes that we want to build use triangles as a base, for example, click the Cube button, their faces are constructed with 2 triangles. In resume TRIANGLES ARE IMPORTANT
 */

//#-hidden-code

let vertexData: [Vertex]
let indexData: [UInt16]

vertexData = [
    Vertex(pos: [/*#-editable-code*//*#-end-editable-code*/-2.0, -1.0, 0.0, 1.0],
           col: Color.green),
    Vertex(pos: [ 2.0, -1.0, 0.0, 1.0],
           col: Color.blue),
    Vertex(pos: [ 0.0,  3.0, 0.0, 1.0],
           col: Color.red)]

indexData = [0, 1, 2]

PlaygroundPage.current.liveView = ViewController(vertexData: vertexData,
                                                 indexData: indexData,
                                                 page: 2)
//#-end-hidden-code
//: [Next](@next)
