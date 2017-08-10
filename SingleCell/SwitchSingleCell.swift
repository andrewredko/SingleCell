//
//  SwitchSingleCell.swift
//  SingleCell
//
//  Created by Andrew Redko on 9/27/2016.
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

/**
 Custom UI control that simulates appearance of UITableViewCell.
 It extends the behavior of SingleCell by placing a switch control
 on the right side (on the place of detailView).
 
 - Note: Set target-action for **valueChanged** event
 to get notified when switch value is changed.
 */
@IBDesignable
open class SwitchSingleCell : SingleCell {
    
    /**
     Defines default values of SwitchSingleCell configuration properties.
     If a value is updated, then it will be applied to all SwitchSingleCell
     instances created further. Thus allowing global configuration
     of SwitchSingleCell.
     */
    open class Defaults : SingleCell.Defaults {
        
        open static var showSwitch = true
        
        open static var isOn = true
        
        open static var onTintColor: UIColor? = nil
        
        open static var thumbTintColor: UIColor? = nil
    }
    
    
    //MARK: - content properties
    
    private let switchControl = UISwitch()
    
    @IBInspectable
    open var showSwitch: Bool = false {
        didSet {
            if showSwitch {
                detailView = switchControl
            }
            else {
                detailView = nil
            }
        }
    }
    
    @IBInspectable
    open var isOn: Bool {
        get {
            return switchControl.isOn
        }
        
        set {
            switchControl.isOn = newValue
        }
    }
    
    
    //MARK: - appearance
    
    @IBInspectable
    open var onTintColor: UIColor! {
        didSet {
            onTintColor = onTintColor ?? Defaults.onTintColor
            switchControl.onTintColor = onTintColor
        }
    }
    
    @IBInspectable
    open var thumbTintColor: UIColor! {
        didSet {
            thumbTintColor = thumbTintColor ?? Defaults.thumbTintColor
            switchControl.thumbTintColor = thumbTintColor
        }
    }
    
    override func setAppearanceForEnabled(_ isEnabled:Bool) {
        super.setAppearanceForEnabled(isEnabled)
        switchControl.isEnabled = isEnabled
    }
    
    
    //MARK: - event-handling
    
    // Allow subsribing to valueChanged event of the switch control
    @objc private func sendValueChangedEvent() {
        self.sendActions(for: .valueChanged)
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
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        
        switchControl.addTarget(self, action: #selector(sendValueChangedEvent), for: .valueChanged)
        
        setCHCRPriorities()
        
        setDefaultValues()
    }
    
    private func setCHCRPriorities() {
        // Set hugging priority greater than of textLabel, so switch does not stretch
        switchControl.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        // Set resistance priority greater than of textLabel, so switch does not shrink
        switchControl.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
    }
    
    private func setDefaultValues() {
        isOn = Defaults.isOn
        showSwitch = Defaults.showSwitch
        onTintColor = nil
        thumbTintColor = nil
    }
}
