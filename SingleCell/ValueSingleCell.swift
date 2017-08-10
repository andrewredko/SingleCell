//
//  ValueSingleCell.swift
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

public protocol SingleCellDetailSetable {
    var detailText: String? { get set }
}

/**
 Custom UI control that simulates appearance of UITableViewCell. It extends
 the behavior of SingleCell by placing detailLabel on the right side
 (on the place of detailView).
 */
@IBDesignable
open class ValueSingleCell : SingleCell, SingleCellDetailSetable {
    
    /**
     Defines default values of ValueSingleCell configuration properties.
     If a value is updated, then it will be applied to all ValueSingleCell
     instances created further. Thus allowing global configuration
     of ValueSingleCell.
     */
    open class Defaults : SingleCell.Defaults {
        
        open static var detailText = "Detail text"
        
        open static var detailTextFont = UIFont.systemFont(ofSize: 17.0)
        
        open static var detailNormalColor = UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
        
        open static var detailHighlightedColor = UIColor(red: 142.0 / 255.0, green: 142.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0)
        
        open static var detailDisabledColor = UIColor(white: 0.69, alpha: 1.0)
        
        open static var detailSelectedColor = UIColor.white
    }
    
    
    //MARK: - content properties
    
    let detailTextLabel = UILabel()
    
    @IBInspectable
    open var detailText: String? {
        didSet {
            detailTextLabel.text = detailText
            
            if detailText != nil {
                detailView = detailTextLabel
            }
            else {
                detailView = nil
            }
        }
    }
    
    
    //MARK: - appearance
    
    /**
     Font of the detail label.
     - Note: The property can be set only programmatically.
     It is not exposed to Interface Builder, because Xcode IB
     still does not support custom properties of the Font type.
     */
    open var detailTextFont: UIFont! {
        didSet {
            detailTextFont = detailTextFont ?? Defaults.detailTextFont
            detailTextLabel.font = detailTextFont
        }
    }
    
    @IBInspectable
    open var detailNormalColor: UIColor! {
        didSet {
            detailNormalColor = detailNormalColor ?? Defaults.detailNormalColor
            if state == .normal {
                detailTextLabel.textColor = detailNormalColor
            }
        }
    }
    
    @IBInspectable
    open var detailHighlightedColor: UIColor! {
        didSet {
            detailHighlightedColor = detailHighlightedColor ?? Defaults.detailHighlightedColor
            if state == .highlighted {
                detailTextLabel.textColor = detailHighlightedColor
            }
        }
    }
    
    @IBInspectable
    open var detailDisabledColor: UIColor! {
        didSet {
            detailDisabledColor = detailDisabledColor ?? Defaults.detailDisabledColor
            if state == .disabled {
                detailTextLabel.textColor = detailDisabledColor
            }
        }
    }
    
    @IBInspectable
    open var detailSelectedColor: UIColor! {
        didSet {
            detailSelectedColor = detailSelectedColor ?? Defaults.detailSelectedColor
            if state == .selected {
                detailTextLabel.textColor = detailSelectedColor
            }
        }
    }
    
    // Use polymorphism to customize highlight behavior
    override func setAppearanceForHighlighted(_ isHighlighted:Bool) {
        super.setAppearanceForHighlighted(isHighlighted)
        
        if isHighlighted {
            self.detailTextLabel.textColor = self.detailHighlightedColor
        }
        else {
            self.detailTextLabel.textColor = self.detailNormalColor
        }
    }
    
    // Use polymorphism to customize disabled appearance
    override func setAppearanceForEnabled(_ isEnabled:Bool) {
        super.setAppearanceForEnabled(isEnabled)
        
        if isEnabled {
            detailTextLabel.textColor = self.detailNormalColor
        }
        else {
            detailTextLabel.textColor = self.detailDisabledColor
        }
    }
    
    
    //MARK: - initializers
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        setupDetailTextLabel()
        
        setDefaultValues()
    }
    
    private func setupDetailTextLabel() {
        detailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        detailTextLabel.textAlignment = .right
        detailTextLabel.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
        detailTextLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
    }
    
    private func setDefaultValues() {
        detailText = Defaults.detailText
        
        detailTextFont = nil
        
        detailNormalColor = nil
        detailHighlightedColor = nil
        detailDisabledColor = nil
        detailSelectedColor = nil
    }
}
