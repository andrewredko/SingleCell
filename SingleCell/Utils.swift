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
    
    static let pixelSize: CGFloat = 1.0 / UIScreen.main.scale
    
    static func arrowImage(color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 8, height: 14))
        let img = renderer.image { ctx in
            ctx.cgContext.setStrokeColor(color.cgColor)
            ctx.cgContext.setLineWidth(2)
            
            ctx.cgContext.move(to: CGPoint(x: 0.75, y: 1))
            ctx.cgContext.addLine(to: CGPoint(x: 6.75, y: 7))
            ctx.cgContext.addLine(to: CGPoint(x: 0.75, y: 13))
            
            ctx.cgContext.strokePath()
        }
        return img
    }
}
