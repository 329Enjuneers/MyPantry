//
//  CategoryViewController.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/25/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryDescription: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var category : PantryCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryName.delegate = self
        categoryDescription.delegate = self
        saveButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == categoryName {
            categoryName.text = textField.text
        }
        else if textField == categoryDescription {
            categoryDescription.text = textField.text
        }
        checkSaveButtonShouldBeEnabled()
    }
    
    private func checkSaveButtonShouldBeEnabled() {
        if categoryName.text != "" {
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
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton.isEqual(sender) {
            let name = categoryName.text
            let description = categoryDescription.text ?? ""
            
            category = PantryCategory(name!, theDescription: description)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
