//
//  InputSingleCell.swift
//  SingleCell
//
//  Created by Andrew Redko on 9/28/2016.
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
 Custom UI control that simulates appearance of UITableViewCell. It extends
 the behavior of ValueSingleCell by adding an ability to set inputView for
 editing of the detailLabel.
 
 - Note: When touched, it automatically becomes first responder and switches
 to the Selected state. When editing is ended, call resignFirstResponder()
 to switch back to the Normal state.
 */
@IBDesignable
open class InputSingleCell : ValueSingleCell {
    
    // MARK: - Content Properties
    
    // Place hidden text field outside of the visible area.
    // Set its frame to any size, but must not be CGRect.null
    private let hiddenTextField = UITextField(frame: CGRect(x:9999, y:1, width:0, height:0))
    
    
    // MARK: - State Appearance
    
    /// Change button appearence to look as selected while being in
    /// an input mode. Set to true when button becomes a first responder.
    /// Set to false when resigning from the first responder.
    override open var isSelected: Bool {
        didSet {
            setBackgroundForSelected(isSelected)
        }
    }
    
    private func setBackgroundForSelected(_ isSelected:Bool) {
        if isSelected {
            backgroundColor = bkgdSelectedColor
            textLabel.textColor = textSelectedColor
            detailTextLabel.textColor = detailSelectedColor
        } else {
            backgroundColor = bkgdNormalColor
            textLabel.textColor = textNormalColor
            detailTextLabel.textColor = detailNormalColor
        }
    }
    
    override func setAppearanceForHighlighted(_ isHighlighted:Bool) {
        if isHighlighted {
            self.backgroundColor = bkgdHighlightedColor
        } else {
            self.setBackgroundForSelected(self.isSelected)
        }
    }
    
    
    // MARK: - Initializers
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(hiddenTextField)
        self.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        
        bkgdSelectedColor = nil
    }
    
    
    // MARK: - Input Delegate
    
    open func setInputView(_ view: UIView?) {
        hiddenTextField.inputView = view
    }
    
    open func setInputAccessoryView(_ view: UIView?) {
        hiddenTextField.inputAccessoryView = view
    }
    
    @objc private func didTouchUpInside(sender: AnyObject?) {
        hiddenTextField.becomeFirstResponder()
    }
    
    override open func resignFirstResponder() -> Bool {
        return hiddenTextField.resignFirstResponder()
    }
    
    override open var isFirstResponder: Bool {
        return hiddenTextField.isFirstResponder
    }
    
    open func setInputDelegate(_ delegate: UITextFieldDelegate?) {
        hiddenTextField.delegate = delegate
    }
    
    open func inputDelegate() -> UITextFieldDelegate? {
        return hiddenTextField.delegate
    }
    
}
