//
//  MetalView.swift
//  MetaliOS
//
//  Created by Peter De Nardo on 28/02/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import Foundation
import UIKit
import Metal

class MetalView: UIView {
    
    var device : MTLDevice!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        device = MTLCreateSystemDefaultDevice()
    }
    
    override func draw(_ dyrtyRect: NSRect) {
        if let drawable = currentDrawable, let rpd = MTLRenderPassDescriptor() {
            rpd.colorAttachments[0].texture = currentDrawable!.texture
            rpd.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
            rpd.colorAttachments[0].loadAction = .clear
            let commandBuffer = device!.makeCommandQueue()?.makeCommandBuffer()
            let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd)
            commandEncoder?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }

}
