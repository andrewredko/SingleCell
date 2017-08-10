//
//  SingleCell.swift
//  SingleCell
//
//  Created by Andrew Redko on 9/24/2016.
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

public enum SingleCellBordersType : Int {
    
    case no = 0
    
    case both = 1
    
    case top = 2
    
    case bottom = 3
    
    case groupFirst = 4
    
    case groupMiddle = 5
    
    case groupLast = 6
}

/**
 Custom UI control that simulates appearance of UITableViewCell, but can be
 used by its own, as a single control, without UITableView. It comprises of
 a main label, optional image on the left and optional detail view on the right.
 Also, it can show disclosure icon on the right side.
 
 Layout of all elements is provided by auto-layout constraints.
 
 SingleCell can be placed, previewed and configured in the interface builder.
 */
@IBDesignable
open class SingleCell : UIControl {
    
    /**
     Defines default values of SingleCell configuration properties.
     If a value is updated, then it will be applied to all SingleCell
     instances created further. Thus allowing global configuration
     of SingleCell.
     
     - Note: To configure an instance only, set corresponding properties of the
     instance itself. Once instance property value has been set and there is a
     need to reset it back to the default value, set instance property to nil.
     
     - Note: Storyboard configuration is loaded before
     AppDelegate.application(didFinishLaunchingWithOptions) method call,
     therefore, if storyboard is used, then disable its automatic loading,
     then override any of Defaults values, and load storyboard manually
     in didFinishLaunchingWithOptions.
     */
    open class Defaults {
        
        open static var text = "Text Label"
        
        open static var image: UIImage? = nil
        
        open static var disclosureColor = UIColor(red: 199.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
        
        open static var showDisclosure = true
        
        open static var spacer: CGFloat = 15
        
        open static var bordersType = 1  // .both
        
        open static var bordersColor = UIColor(white: 0.75, alpha: 1.0)
        
        fileprivate static let borderHeight = Utils.pixelSize
        
        open static var textFont = UIFont.systemFont(ofSize: 17.0)
        
        open static var backgroundNormalColor = UIColor.white
        
        open static var backgroundHighlightedColor = UIColor(white: 0.82, alpha: 1.0)
        
        open static var backgroundDisabledColor = backgroundNormalColor
        
        open static var backgroundSelectedColor = UIColor.yellow
        
        open static var textNormalColor = UIColor.darkText
        
        open static var textHighlightedColor = UIColor.darkText
        
        open static var textDisabledColor = UIColor(white: 0.69, alpha: 1.0)
        
        open static var textSelectedColor = UIColor.white
    }
    
    
    //MARK: - content properties
    
    let textLabel = UILabel()
    
    /** Text of the main label. */
    @IBInspectable
    open var text: String? {
        didSet {
            textLabel.text = text ?? Defaults.text
        }
    }
    
    let imageView = UIImageView()
    
    /**
     Image appearing on the left from the main label.
     - Note: To hide an image, set it to nil.
     */
    @IBInspectable
    open var image: UIImage? {
        didSet {
            setImage(image)
        }
    }
    
    private func setImage(_ image:UIImage?) {
        imageView.image = image
        
        if imageView.superview != nil { imageView.removeFromSuperview() }
        
        if image != nil {
            self.addSubview(imageView)
            
            // Re-create imageView constraints
            addImageViewConstraints()
            
            // Update constraints for presence of imageView
            setTextLabelLeadingConstraint(toAnchor: imageView.trailingAnchor)
        }
        else {
            // Update constraints for absence of imageView
            setTextLabelLeadingConstraint(toAnchor: self.leadingAnchor)
            // There is no need to remove imageView constraints, because
            // they are removed automatically when the view is removedFromSuperview
        }
    }
    
    /**
     View appearing on the right from the main label and
     before the disclosureImage.
     - Note: To hide a view, set it to nil.
     */
    open var detailView: UIView? {
        didSet {
            setDetailView(detailView, oldView:oldValue)
        }
    }
    
    private func setDetailView(_ view:UIView?, oldView:UIView?) {
        // If there was a view before, then remove it
        oldView?.removeFromSuperview()
        
        // Check if there is a new detailView and
        // add or update constraints respectively
        if let view = view {
            self.addSubview(view)
            
            // Re-create detailView constraints
            addDetailViewConstraints(view)
            
            // Update constraints for presence of detailView
            setDisclosureIconLeadingConstraint(toAnchor: view.trailingAnchor)
        }
        else {
            // Update constraints for absence of detailView
            setDisclosureIconLeadingConstraint(toAnchor: textLabel.trailingAnchor)
        }
    }
    
    let disclosureImageView = UIImageView()
    
    /**
     Changes the color of the disclosureImage.
     - Note: Changing the image itself is not provided.
     */
    @IBInspectable
    open var disclosureColor: UIColor! {
        didSet {
            disclosureColor = disclosureColor ?? Defaults.disclosureColor
            disclosureImageView.image = Utils.arrowImage(color: disclosureColor)
        }
    }
    
    // IB fails to get discloseImage.size.width value, so it is hardcoded.
    // Hardcode is fine, because disclosureImage size should not be changed.
    private let disclosureImageWidth: CGFloat = 8
    
    @IBInspectable
    open var showDisclosure: Bool = false {
        didSet {
            showDisclosure(showDisclosure)
        }
    }
    
    private func showDisclosure(_ show:Bool) {
        if show {
            // Set constraints to show icon
            disclosureImageView.isHidden = false
            disclosureImageLeadingContraint.constant = spacer
        }
        else {
            // Set constraints to hide icon
            disclosureImageView.isHidden = true
            disclosureImageLeadingContraint.constant = -disclosureImageWidth
        }
    }
    
    
    //MARK: - appearance
    
    /**
     Font of the main label.
     - Note: The property can be set only programmatically.
     It is not exposed to Interface Builder, because Xcode IB
     still does not support custom properties of the Font type.
     */
    open var textFont: UIFont! {
        didSet {
            textFont = textFont ?? Defaults.textFont
            textLabel.font = textFont
        }
    }
    
    @IBInspectable
    open var textNormalColor: UIColor! {
        didSet {
            textNormalColor = textNormalColor ?? Defaults.textNormalColor
            if state == .normal {
                textLabel.textColor = textNormalColor
            }
        }
    }
    
    @IBInspectable
    open var textHighlightedColor: UIColor! {
        didSet {
            textHighlightedColor = textHighlightedColor ?? Defaults.textHighlightedColor
            if state == .highlighted {
                textLabel.textColor = textHighlightedColor
            }
        }
    }
    
    @IBInspectable
    open var textDisabledColor: UIColor! {
        didSet {
            textDisabledColor = textDisabledColor ?? Defaults.textDisabledColor
            if state == .disabled {
                textLabel.textColor = textDisabledColor
            }
        }
    }
    
    @IBInspectable
    open var textSelectedColor: UIColor! {
        didSet {
            textSelectedColor = textSelectedColor ?? Defaults.textSelectedColor
            if state == .selected {
                textLabel.textColor = textSelectedColor
            }
        }
    }
    
    @IBInspectable
    open var bkgdNormalColor: UIColor! {
        didSet {
            bkgdNormalColor = bkgdNormalColor ?? Defaults.backgroundNormalColor
            if state == .normal {
                backgroundColor = bkgdNormalColor
            }
        }
    }
    
    @IBInspectable
    open var bkgdHighlightedColor: UIColor! {
        didSet {
            bkgdHighlightedColor = bkgdHighlightedColor ?? Defaults.backgroundHighlightedColor
            if state == .highlighted {
                backgroundColor = bkgdHighlightedColor
            }
        }
    }
    
    @IBInspectable
    open var bkgdDisabledColor: UIColor! {
        didSet {
            bkgdDisabledColor = bkgdDisabledColor ?? Defaults.backgroundDisabledColor
            if state == .disabled {
                backgroundColor = bkgdDisabledColor
            }
        }
    }
    
    @IBInspectable
    open var bkgdSelectedColor: UIColor! {
        didSet {
            bkgdSelectedColor = bkgdSelectedColor ?? Defaults.backgroundSelectedColor
            if state == .selected {
                backgroundColor = bkgdSelectedColor
            }
        }
    }
    
    
    //MARK: - state appearance
    
    override open var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.18) {
                self.setAppearanceForHighlighted(self.isHighlighted)
            }
        }
    }
    
    func setAppearanceForHighlighted(_ isHighlighted:Bool) {
        if isHighlighted {
            self.backgroundColor = self.bkgdHighlightedColor
            self.textLabel.textColor = self.textHighlightedColor
        }
        else {
            self.backgroundColor = self.bkgdNormalColor
            self.textLabel.textColor = self.textNormalColor
        }
    }
    
    
    override open var isEnabled: Bool {
        didSet {
            self.setAppearanceForEnabled(self.isEnabled)
        }
    }
    
    func setAppearanceForEnabled(_ isEnabled:Bool) {
        if isEnabled {
            backgroundColor = self.bkgdNormalColor
            textLabel.textColor = self.textNormalColor
            imageView.alpha = 1.0
            disclosureImageView.alpha = 1.0
        }
        else {
            backgroundColor = self.bkgdDisabledColor
            textLabel.textColor = self.textDisabledColor
            imageView.alpha = 0.5
            disclosureImageView.alpha = 0.6
        }
    }
    
    
    //MARK: - initializers
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(imageView)
        self.addSubview(textLabel)
        self.addSubview(disclosureImageView)
        
        addPermanentLayoutConstraints()
        
        setCHCRPriorities()
        
        setupBorders()
        
        setDefaultValues()
    }
    
    private func setDefaultValues() {
        text = nil
        
        image = Defaults.image
        
        detailView = nil
        
        disclosureColor = nil
        showDisclosure = Defaults.showDisclosure
        
        bkgdNormalColor = nil
        bkgdHighlightedColor = nil
        bkgdDisabledColor = nil
        bkgdSelectedColor = nil
        
        textNormalColor = nil
        textHighlightedColor = nil
        textDisabledColor = nil
        textSelectedColor = nil
        
        textFont = nil
        
        bordersType = Defaults.bordersType
        bordersColor = nil
    }
    
    
    //MARK: - constraints
    
    private var imageViewLeadingContraint: NSLayoutConstraint!
    private var textLabelLeadingContraint: NSLayoutConstraint!
    private var detailViewLeadingContraint: NSLayoutConstraint!
    private var disclosureImageLeadingContraint: NSLayoutConstraint!
    private var disclosureImageTrailingContraint: NSLayoutConstraint!
    
    /** Horizontal distance between each UI element (i.e. image, text,
     detailView and disclosureImage). */
    @IBInspectable
    open var spacer: CGFloat = Defaults.spacer {
        didSet {
            textLabelLeadingContraint.constant = spacer
            imageViewLeadingContraint?.constant = spacer
            if showDisclosure {
                disclosureImageLeadingContraint?.constant = spacer
            }
            disclosureImageTrailingContraint?.constant = -spacer
        }
    }
    
    private func setCHCRPriorities() {
        imageView.setContentHuggingPriority(252, for: .horizontal)
        textLabel.setContentHuggingPriority(251, for: .horizontal)
        disclosureImageView.setContentHuggingPriority(252, for: .horizontal)
        
        imageView.setContentCompressionResistancePriority(752, for: .horizontal)
        textLabel.setContentCompressionResistancePriority(750, for: .horizontal)
        disclosureImageView.setContentCompressionResistancePriority(752, for: .horizontal)
    }
    
    private func addPermanentLayoutConstraints() {
        // Using auto-layout
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        disclosureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        disclosureImageTrailingContraint = disclosureImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacer)
        disclosureImageTrailingContraint.isActive = true
        disclosureImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func addImageViewConstraints() {
        imageViewLeadingContraint = imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacer)
        imageViewLeadingContraint.isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    private func setTextLabelLeadingConstraint(toAnchor: NSLayoutXAxisAnchor) {
        if let constraint = textLabelLeadingContraint {
            self.removeConstraint(constraint)
        }
        textLabelLeadingContraint = textLabel.leadingAnchor.constraint(equalTo: toAnchor, constant: spacer)
        textLabelLeadingContraint.isActive = true
    }
    
    private func addDetailViewConstraints(_ view: UIView) {
        detailViewLeadingContraint = view.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: spacer)
        detailViewLeadingContraint.isActive = true
        view.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor).isActive = true
    }
    
    private func setDisclosureIconLeadingConstraint(toAnchor: NSLayoutXAxisAnchor) {
        if let constraint = disclosureImageLeadingContraint {
            self.removeConstraint(constraint)
        }
        let constant = showDisclosure ? spacer : -disclosureImageWidth
        disclosureImageLeadingContraint = disclosureImageView.leadingAnchor.constraint(equalTo: toAnchor, constant: constant)
        disclosureImageLeadingContraint.isActive = true
    }
    
    
    //MARK: - borders
    
    private var topBorder = UIView()
    private var bottomBorder = UIView()
    private var bottomShortBorder = UIView()
    
    @IBInspectable
    open var bordersType: Int = 1 {
        didSet {
            guard 0 ... 6 ~= bordersType  else {
                fatalError("Unknown borders type")
            }
            showBorders(SingleCellBordersType(rawValue: bordersType)!)
        }
    }
    
    @IBInspectable
    open var bordersColor: UIColor! {
        didSet {
            bordersColor = bordersColor ?? Defaults.bordersColor
            topBorder.backgroundColor = bordersColor
            bottomBorder.backgroundColor = bordersColor
            bottomShortBorder.backgroundColor = bordersColor
        }
    }
    
    private func showBorders(_ borders: SingleCellBordersType) {
        // Firstly hide all
        topBorder.isHidden = true
        bottomBorder.isHidden = true
        bottomShortBorder.isHidden = true
        
        // Then show only needed ones
        switch borders {
        case .no:
            break
        case .top:
            topBorder.isHidden = false
        case .bottom, .groupLast:
            bottomBorder.isHidden = false
        case .both:
            topBorder.isHidden = false
            bottomBorder.isHidden = false
        case .groupFirst:
            topBorder.isHidden = false
            bottomShortBorder.isHidden = false
        case .groupMiddle:
            bottomShortBorder.isHidden = false
        }
    }
    
    private func setupBorders() {
        topBorder.backgroundColor = Defaults.bordersColor
        self.addSubview(topBorder)
        
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        addCommonConstraintsForBorderView(topBorder)
        
        bottomBorder.backgroundColor = Defaults.bordersColor
        self.addSubview(bottomBorder)
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        addCommonConstraintsForBorderView(bottomBorder)
        
        bottomShortBorder.backgroundColor = Defaults.bordersColor
        self.addSubview(bottomShortBorder)
        
        bottomShortBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomShortBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomShortBorder.leadingAnchor.constraint(equalTo: self.textLabel.leadingAnchor).isActive = true
        bottomShortBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomShortBorder.heightAnchor.constraint(equalToConstant: Defaults.borderHeight).isActive = true
    }
    
    private func addCommonConstraintsForBorderView(_ borderView: UIView) {
        borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        borderView.heightAnchor.constraint(equalToConstant: Defaults.borderHeight).isActive = true
    }
    
}
