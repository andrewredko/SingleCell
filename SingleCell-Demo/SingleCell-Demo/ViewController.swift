//
//  ViewController.swift
//  SingleCell-Demo
//
//  Created by Andrew Redko on 9/27/2016.
//  Copyright © 2016 Andrew Redko. All rights reserved.
//

import UIKit
import SingleCell

class ViewController: UIViewController {
    
    // MARK: - Private vars
    
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var singleCell: SingleCell!
    @IBOutlet weak var valueSingleCell: ValueSingleCell!
    @IBOutlet weak var switchSingleCell: SwitchSingleCell!
    @IBOutlet weak var inputSingleCell: InputSingleCell!
    @IBOutlet weak var actionResultLabel: UILabel!
    
    @IBOutlet weak var showDetailViewCell: SwitchSingleCell!
    @IBOutlet weak var showDisclosureCell: SwitchSingleCell!
    @IBOutlet weak var showImageCell: SwitchSingleCell!
    @IBOutlet weak var darkColorThemeCell: SwitchSingleCell!
    
    
    // MARK: - Show Content IBActions
    
    private var singleCellInitImage: UIImage!
    private var valueSingleCellInitImage: UIImage!
    private var switchSingleCellInitImage: UIImage!
    private var inputSingleCellInitImage: UIImage!
    
    @IBAction func showImageValueChanged(_ sender: SwitchSingleCell) {
        if singleCellInitImage == nil {
            preserveInitialImages()
        }
        if sender.isOn {
            singleCell.image = singleCellInitImage
            valueSingleCell.image = valueSingleCellInitImage
            switchSingleCell.image = switchSingleCellInitImage
            inputSingleCell.image = inputSingleCellInitImage
        } else {
            singleCell.image = nil
            valueSingleCell.image = nil
            switchSingleCell.image = nil
            inputSingleCell.image = nil
        }
    }
    
    fileprivate func preserveInitialImages() {
        singleCellInitImage = singleCell.image
        valueSingleCellInitImage = valueSingleCell.image
        switchSingleCellInitImage = switchSingleCell.image
        inputSingleCellInitImage = inputSingleCell.image
    }
    
    @IBAction func showDetailViewValueChanged(_ sender: SwitchSingleCell) {
        if sender.isOn {
            valueSingleCell.detailText = ValueSingleCell.Defaults.detailText
            switchSingleCell.showSwitch = true
            inputSingleCell.detailText = InputSingleCell.Defaults.detailText
        } else {
            valueSingleCell.detailText = nil
            switchSingleCell.showSwitch = false
            inputSingleCell.detailText = nil
        }
    }
    
    @IBAction func showDisclosureValueChanged(_ sender: SwitchSingleCell) {
        let show = sender.isOn
        singleCell.showDisclosure = show
        valueSingleCell.showDisclosure = show
        switchSingleCell.showDisclosure = show
        inputSingleCell.showDisclosure = show
    }
    
    
    // MARK: - Dark Theme IBAction
    
    @IBAction func darkThemeChanged(_ sender: SwitchSingleCell) {
        let isDark = sender.isOn
        if isDark {
            setDarkColorTheme()
        } else {
            setDefaultColorTheme()
        }
    }
    
    private func setDefaultColorTheme() {
        setDefaultColorTheme(onCell: singleCell)
        setDefaultColorTheme(onCell: valueSingleCell)
        setDefaultColorTheme(onCell: switchSingleCell)
        setDefaultColorTheme(onCell: inputSingleCell)
    
        setDefaultColorTheme(onCell: showImageCell)
        setDefaultColorTheme(onCell: showDetailViewCell)
        setDefaultColorTheme(onCell: showDisclosureCell)
        setDefaultColorTheme(onCell: darkColorThemeCell)
        
        self.view.backgroundColor = UIColor(red: 239 / 255.0, green: 239 / 255.0, blue: 244 / 255.0, alpha: 1.0)
        
        setStatusBarStyle(isDarkTheme: false)
    }

    private func setDarkColorTheme() {
        setDarkColorTheme(onCell: singleCell)
        setDarkColorTheme(onCell: valueSingleCell)
        setDarkColorTheme(onCell: switchSingleCell)
        setDarkColorTheme(onCell: inputSingleCell)
        
        setDarkColorTheme(onCell: showImageCell)
        setDarkColorTheme(onCell: showDetailViewCell)
        setDarkColorTheme(onCell: showDisclosureCell)
        setDarkColorTheme(onCell: darkColorThemeCell)
        
        self.view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        
        setStatusBarStyle(isDarkTheme: true)
    }
    
    private func setDefaultColorTheme(onCell cell: SingleCell) {
        cell.bkgdNormalColor = nil
        cell.bordersColor    = nil
        cell.textNormalColor = nil
        cell.disclosureColor = nil
        
        if let cell = cell as? ValueSingleCell {
            cell.detailNormalColor = nil
        } else if let cell = cell as? SwitchSingleCell {
            cell.onTintColor = nil
        }
        
        if let cell = cell as? InputSingleCell {
            cell.detailNormalColor = UIColor(red: 48 / 255.0, green: 131 / 255.0,
                                             blue: 251 / 255.0, alpha: 1.0)
        }
    }
    
    private func setDarkColorTheme(onCell cell: SingleCell) {
        cell.bkgdNormalColor = UIColor(white: 0.10, alpha: 1.0)
        cell.bordersColor    = UIColor(white: 0.18, alpha: 1.0)
        cell.textNormalColor = UIColor(white: 0.84, alpha: 1.0)
        cell.disclosureColor = UIColor(red: 204 / 255.0, green: 204 / 255.0,
                                       blue: 206 / 255.0, alpha: 1.0)
        
        if let cell = cell as? ValueSingleCell {
            cell.detailNormalColor = UIColor(white: 0.84, alpha: 1.0)
        } else if let cell = cell as? SwitchSingleCell {
            cell.onTintColor = UIColor(red: 57 / 255.0, green: 139 / 255.0,
                                       blue: 247 / 255.0, alpha: 1.0)
        }
    }
    
    private func setStatusBarStyle(isDarkTheme: Bool) {
        UIApplication.shared.statusBarStyle = isDarkTheme ? .lightContent : .default
    }
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePicker()
        setupInputSingleCell()
        assignActionsToTouchEvents()
    }
    
    private func setupDatePicker() {
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(pickerDateChanged), for: .valueChanged)
    }
    
    func pickerDateChanged() {
        inputSingleCell.detailText = stringFromDate(datePicker.date)
    }
    
    func stringFromDate(_ optDate : Date?) -> String {
        guard let date = optDate else {
            return ""
        }
        return dateFormatter.string(from: date)
    }
    
    private func setupInputSingleCell() {
        inputSingleCell.setInputDelegate(self)
        
        inputSingleCell.setInputView(datePicker)
        
        // Add input accessory view with Done button on the right side
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissDatePicker))
        toolBar.setItems([flexBarButton, doneButton], animated: false)
        
        inputSingleCell.setInputAccessoryView(toolBar)
    }
    
    func dismissDatePicker() {
        if inputSingleCell.isFirstResponder {
            inputSingleCell.detailText = stringFromDate(datePicker.date)
            _ = inputSingleCell.resignFirstResponder()
        }
    }
    
    private func assignActionsToTouchEvents() {
        // Standard "addTarget" is used to subscribe to touch events
        singleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
        switchSingleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
        valueSingleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
        inputSingleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
    }
    
    @objc private func cellTouched(_ sender: SingleCell) {
        self.actionResultLabel.alpha = 1.0
        self.actionResultLabel.text = "\"\(sender.text!)\" tapped."
        
        // Hide message after some delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            UIView.animate(withDuration: 0.2, animations: {
                self.actionResultLabel.alpha = 0.0
            })
        })
    }
    
}


// MARK: - UITextFieldDelegate

extension ViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let activeButton = textField.superview as! UIControl
        activeButton.isSelected = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let activeButton = textField.superview as! InputSingleCell
        _ = activeButton.resignFirstResponder()
        activeButton.isSelected = false
    }
    
}
