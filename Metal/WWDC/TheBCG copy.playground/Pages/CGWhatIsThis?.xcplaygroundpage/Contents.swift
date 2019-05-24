//: [Previous](@previous)

/*:
 # Ow What is Computer Graphics?
 
 Recently I started to study in my college this large area of ​​computer science and while I was lost in this huge amount of content I made my first question as clear and objective as possible, what is CG? We can respond in many different ways to this question but in a nutshell, Computer Graphics is about almost everything that does not involve sound or text on a computer more specifically when we treat images and visual models on the computer.
 
 In this playgrounds I want to try as much as possible to explain some simple concepts of this area that I know so little but already I had immensely.
 
 I will avoid delving into very deep mathematical concepts because I do not master them, STILL💪💪💪 !!! And I also want to keep the content as playful as possible in a pleasant and delicious way
 
 on this page I'll cover about
 * Vertex
 * 3D
 
 First, Vertex in nerd language is a data structure, we use them to locate the position of our representations in 2D or 3D on the screen, for normal people, Vertex are small and beautiful points that together we use to construct 2D or 3D shapes
 */

//#-hidden-code
import PlaygroundSupport

let vertexData: [Vertex]
let indexData: [UInt16]
let allowsRotate: Bool
//#-end-hidden-code
vertexData = [
    Vertex(pos: [/*#-editable-code*/-2.0, -1.0, 0.0, 1.0 /*#-end-editable-code*/],
           col: Color/*#-editable-code*/.green/*#-end-editable-code*/),
    Vertex(pos: [/*#-editable-code*/ 2.0, -1.0, 0.0, 1.0 /*#-end-editable-code*/],
           col: Color/*#-editable-code*/.blue/*#-end-editable-code*/),
    Vertex(pos: [/*#-editable-code*/ 0.0, 3.0, 0.0, 1.0 /*#-end-editable-code*/],
           col: Color/*#-editable-code*/.red/*#-end-editable-code*/)]

indexData = [0, 1, 2]

allowsRotate = /*#-editable-code*/false/*#-end-editable-code*/

//#-hidden-code
PlaygroundPage.current.liveView = ViewController(allowsRotate: allowsRotate,
                                                 vertexData: vertexData,
                                                 indexData: indexData)
//#-end-hidden-code
//: [Next](@next)
