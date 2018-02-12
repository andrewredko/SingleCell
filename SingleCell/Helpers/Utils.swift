//
//  Utils.swift
//  SingleCell
//
//  Created by Andrew Redko on 9/26/2016.
//
//  The MIT License
//  Copyright © 2016 Andrew Redko
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation files
//  (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, merge,
//  publish, distribute, sublicense, and/or sell copies of the Software,
//  and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


import UIKit

struct Utils {
    
    // MARK: - Public vars
    
    static let pixelSize: CGFloat = 1.0 / UIScreen.main.scale
    
    
    // MARK: - Draw Arrow Image
    
    private struct Arrow {
        static let size = CGSize(width: 8, height: 14)
        static let lineWidth: CGFloat = 2.0
        static let points = [
            CGPoint(x: 0.75, y: 1.0),
            CGPoint(x: 6.75, y: 7.0),
            CGPoint(x: 0.75, y: 13.0)
        ]
    }
    
    static func arrowImage(color: UIColor) -> UIImage {
        if #available(iOS 10, *) {
            return drawArrowImageUsingRenderer(color: color)
        } else {
            return drawArrowImageUsingCoreGraphics(color: color)
        }
    }
    
    @available(iOS 10, *)
    private static func drawArrowImageUsingRenderer(color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: Arrow.size)
        let image = renderer.image { ctx in
            ctx.cgContext.setStrokeColor(color.cgColor)
            ctx.cgContext.setLineWidth(Arrow.lineWidth)
            
            ctx.cgContext.move(to:    Arrow.points[0])
            ctx.cgContext.addLine(to: Arrow.points[1])
            ctx.cgContext.addLine(to: Arrow.points[2])
            
            ctx.cgContext.strokePath()
        }
        return image
    }
    
    private static func drawArrowImageUsingCoreGraphics(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(Arrow.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.setStrokeColor(color.cgColor)
        ctx.setLineWidth(Arrow.lineWidth)
        
        ctx.move(to:    Arrow.points[0])
        ctx.addLine(to: Arrow.points[1])
        ctx.addLine(to: Arrow.points[2])

        ctx.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
