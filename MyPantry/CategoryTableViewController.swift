//
//  CategoryTableViewController.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/25/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categories = [PantryCategory]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleCategories()

    }
    
    func loadSampleCategories() {
        if let savedCategories = PantryCategory.loadCategories() {
            categories += savedCategories
        }
    }
    
    func saveCategories() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(categories, toFile: PantryCategory.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save categories...")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CategoryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryTableViewCell
        
        let category = categories[indexPath.row]

        cell.categoryName.text = category.name
        cell.categoryDescription.text = category.getDisplayableDescription()
        cell.categoryNumberOfItems.text = String(category.getNumberOfPantryItems())

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategory" {
            let nav = segue.destination as! UINavigationController
            let categoryItemViewController = nav.topViewController as! CategoryItemsTableViewController
            if let selectedCategoryCell = sender as? CategoryTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCategoryCell)!
                let selectedCategory = categories[indexPath.row]
                categoryItemViewController.category = selectedCategory
            }
        }
    }
    
    @IBAction func unwindToCategoryList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CategoryViewController, let category = sourceViewController.category {
            // Add a new pantryItem.
            let newIndexPath = IndexPath(row: categories.count, section: 0)
            categories.append(category)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            saveCategories()
        }
    }
    
}
