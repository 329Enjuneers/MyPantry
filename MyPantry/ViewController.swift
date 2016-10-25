//
//  ViewController.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/18/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var pantryItemName: UITextField!
    @IBOutlet weak var pantryItemUnit: UITextField!
    @IBOutlet weak var pantryItemImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var pantryItem: PantryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pantryItemName.delegate = self
        pantryItemUnit.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == pantryItemName {
            pantryItemName.text = textField.text
        }
        else if textField == pantryItemUnit {
            pantryItemUnit.text = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        pantryItemImage.image = selectedImage
        
        // Dismiss the picker.
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
            let photo = pantryItemImage.image
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            pantryItem = PantryItem(name: name, amountRemainingInOunces: 20, photo: photo, unit: unit)
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

