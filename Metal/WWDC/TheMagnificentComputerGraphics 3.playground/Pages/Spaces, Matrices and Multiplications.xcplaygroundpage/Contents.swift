//: [Previous](@previous)
/*:
 # Spaces, Matrices and Multiplications
 
 In this Page we will
 * Understand Spaces
 * Make some fun with a 3D model
 * And say good bye 😭
 
 We have 4 main spaces, the object, the world, the camera and the screen.
 The space of the object consists in the position of its vertices having as reference to its own center (x = 0, y = 0, z = 0). The world space can have the desired size and we use to position several elements that have the same plane as reference. The camera space is the construction of what we are going to see on the screen, basically we construct a camera obscura using mathematics, configuring the distance of the vision and the angles so we limit what we will fill in the screen. At least, on the screen space we take this vision and we pass to the 2D environment of the monitor looking the different sizes they may have.
 
 when we are working with spaces at all times we are doing transformations, such as when the object space is transformed into the world space by matrix operations, we basically take the vertices and their positions and multiply them by the matrix that by convention we call the Model matrix, at the end of everything Let's have our world space with the positioned object. In every transformation we have to perform this type of operation with the correct matrices
 
 🏃‍♂️💨 Run the code again and let's play, On the screen we have
 * Buttons with a corresponding color of their vertices, they control a position of each,
 * Two sliders they control of camera rotation in relation to the center of the space.
 * FillMode changes the way vertices are filled.
 
 - Important:
 Note that when you change the position of the vertices, you are constantly changing the space of the world, fun rigth? 😄
 
 
 */
//#-hidden-code

import PlaygroundSupport

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
                                                 page: 3)
//#-end-hidden-code

//: I would like to thank you for your attention, and I hope you have finished this Playgrounds understanding a little more about computer graphics and liking it as I like 😁, Good Bye 👋

//: [Next](@next)
