//: [Previous](@previous)

/*:
 # Ow What is Computer Graphics?
 
 - Important:
 I strongly recommend that you read the texts and execute the code only at the bottom of the page, in this way understanding what is happening on the screen
 
 - Important:
 The experience will be more enjoyable in Landscape with the LineView alongside the code
 
 Recently I started to study in my college this large area of ​​computer science and while I was lost in this huge amount of content I made my first question as clear and objective as possible, what is CG? We can respond in many different ways to this question but in a nutshell, Computer Graphics is about almost everything that does not involve sound or text on a computer more specifically when we treat images and visual models on the computer.
 
 In this playgrounds I want to try as much as possible to explain some simple concepts of this area that I know so little but already I love.
 
 I will avoid delving into very deep mathematical concepts because I do not master them, STILL💪💪💪 !!! And I also want to keep the content as playful as possible
 
 on this page I'll cover about
 * Vertex, the base of everything
 
 First, Vertex in nerd language is a data structure, we use them to locate the position of our representations in 2D or 3D on the screen, for normal people, Vertex are small and beautiful points that together we use to construct 2D or 3D shapes
 
 */

//#-hidden-code
import PlaygroundSupport

let vertexData: [Vertex]
let indexData: [UInt16]
//#-end-hidden-code

/*:
    The vertexData array, contain the position of the three triangle verteces and they respective colors, you can changue here
 */
vertexData = [
    Vertex(pos: [/*#-editable-code*/ -2.0,/*#-end-editable-code*//*#-editable-code*/ -1.0,/*#-end-editable-code*//*#-editable-code*/ 0.0,/*#-end-editable-code*//*#-editable-code*/ 1.0 /*#-end-editable-code*/],
           col: Color/*#-editable-code*/.green/*#-end-editable-code*/),
    Vertex(pos: [/*#-editable-code*/ 2.0,/*#-end-editable-code*//*#-editable-code*/ -1.0,/*#-end-editable-code*//*#-editable-code*/ 0.0,/*#-end-editable-code*//*#-editable-code*/ 1.0 /*#-end-editable-code*/],
           col: Color/*#-editable-code*/.blue/*#-end-editable-code*/),
    Vertex(pos: [/*#-editable-code*/ 0.0,/*#-end-editable-code*//*#-editable-code*/ 3.0,/*#-end-editable-code*//*#-editable-code*/ 0.0,/*#-end-editable-code*//*#-editable-code*/ 1.0 /*#-end-editable-code*/],
           col: Color/*#-editable-code*/.red/*#-end-editable-code*/)]
/*:
    The index data contains the information to connect the vertices to each other, creating the lines that together form the geometric shape. 0 is the first vertice on VertexData 1 the second and so on
 
Now that you have made your vertex changes, 🏃‍♀️💨 run the code to see them
 */
indexData = [0, 1, 2]

//#-hidden-code
PlaygroundPage.current.liveView = ViewController(vertexData: vertexData,
                                                 indexData: indexData,
                                                 page: 1)
//#-end-hidden-code
//: [Next](@next)
