//
//  ViewController.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/18/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import UIKit

class MyPantryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var pantryItemName: UITextField!
    @IBOutlet weak var pantryItemAmount: UITextField!
    @IBOutlet weak var pantryItemUnit: UITextField!
    @IBOutlet weak var pantryItemImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var pantryItem: PantryItem?
    var VALID_UNITS = ["", "oz", "lb", "mL", "L", "g"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pantryItemName.delegate = self
        pantryItemAmount.delegate = self
        pantryItemUnit.delegate = self
        saveButton.isEnabled = false
        
        makeUnitPickerView()
    }
    
    func makeUnitPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MyPantryViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MyPantryViewController.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pantryItemUnit.inputView = pickerView
        pantryItemUnit.inputAccessoryView = toolBar
    }
    
    func donePicker() {
        pantryItemUnit.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return VALID_UNITS.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return VALID_UNITS[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pantryItemUnit.text = VALID_UNITS[row]
    }

    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == pantryItemName {
            pantryItemName.text = textField.text
        }
        else if textField == pantryItemUnit {
            pantryItemUnit.text = textField.text
        }
        else if textField == pantryItemAmount {
            pantryItemAmount.text = textField.text
        }
        checkSaveButtonShouldBeEnabled()
    }
    
    private func checkSaveButtonShouldBeEnabled() {
        if pantryItemName.text != "" && pantryItemUnit.text != "" && pantryItemAmount.text != "" {
            saveButton.isEnabled = true
        }
        else {
            saveButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        pantryItemImage.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton.isEqual(sender) {
            let name = pantryItemName.text ?? ""
            let unit = pantryItemUnit.text ?? ""
            let amountRemainingInOunces = Float(pantryItemAmount.text ?? "0")!
            let photo = pantryItemImage.image
            
            pantryItem = PantryItem(name: name, amountRemainingInOunces: amountRemainingInOunces, photo: photo, unit: unit)
        }
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboards.
        pantryItemName.resignFirstResponder()
        pantryItemUnit.resignFirstResponder()

        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()

        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary

        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self

        present(imagePickerController, animated: true, completion: nil)
    }
    
    
}

