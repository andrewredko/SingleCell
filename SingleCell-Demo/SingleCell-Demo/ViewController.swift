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
    
    //MARK: - outlets & actions
    
    @IBOutlet weak var singleCell: SingleCell!
    @IBOutlet weak var valueSingleCell: ValueSingleCell!
    @IBOutlet weak var switchSingleCell: SwitchSingleCell!
    @IBOutlet weak var inputSingleCell: InputSingleCell!
    @IBOutlet weak var actionResultLabel: UILabel!
    
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
        }
        else {
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
        }
        else {
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
    
    
    //MARK: - setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDatePicker()
        
        setupInputSingleCell()
        
        addActionsForTouchEvents()
    }
    
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    
    private func setupDatePicker() {
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        datePicker.datePickerMode = .date
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
    
    private func addActionsForTouchEvents() {
        // Standard "addTarget" is used to subscribe to touch events
        singleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
        switchSingleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
        valueSingleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
        inputSingleCell.addTarget(self, action: #selector(cellTouched), for: .touchUpInside)
    }
    
    @objc private func cellTouched(_ sender: SingleCell) {
        self.actionResultLabel.alpha = 1.0
        self.actionResultLabel.text = "\"\(sender.text!)\" touched"
        
        // Hide message after some delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.actionResultLabel.alpha = 0.0
            })
        })
    }
}


//MARK: - UITextFieldDelegate

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

