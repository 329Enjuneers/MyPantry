//
//  PantryItemTableViewController.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/18/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import UIKit

class MyPantryTableViewController: UITableViewController {
    
    // MARK: Properties
    var categories = [PantryCategory]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = getCategories()
        
        if categories.count == 0 {
            categories = [PantryCategory.makeGeneralCategory()]
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return getCategories().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = getCategories()[section]
        return category.getNumberOfPantryItems()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MyPantryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyPantryTableViewCell
        let category = getCategories()[indexPath.section]
        let pantryItem = category.pantryItems[indexPath.row]
        
        cell.nameLabel.text = pantryItem.name
        cell.amountRemainingLabel.text = String(pantryItem.amountRemainingInOunces)
        cell.unitLabel.text = pantryItem.unit
        cell.photoImageView.image = pantryItem.photo

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = getCategories()[section]
        return "\(category.name)"
    }
    
    @IBAction func unwindToPantryItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MyPantryViewController, let pantryItem = sourceViewController.pantryItem, let category = sourceViewController.selectedCategory {
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                //pantry item is being edited so update existing pantryItem
                category.pantryItems[selectedIndexPath.row] = pantryItem
                category.save()
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else
            {
                // Add a new pantryItem.
                let section = PantryCategory.indexOf(category: category)
                let newIndexPath = IndexPath(row: category.getNumberOfPantryItems(), section: section)
                
                category.addPantryItem(pantryItem)
                category.save()
                
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
            
            
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let category = getCategories()[indexPath.section]
            category.removePantryItemAt(index : indexPath.row)
            PantryCategory.saveCategories(categories: categories)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func getCategories() -> [PantryCategory]{
        if let savedCategories = PantryCategory.loadCategories() {
            categories = savedCategories
        }
        return categories
    }

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
        
        if segue.identifier == "ShowDetail"
        {
            let nav = segue.destination as! UINavigationController
            let pantryItemDetailViewController = nav.topViewController as! MyPantryViewController
            //Get the cell that generated this segue
            if let selectedPantryItemCell = sender as? MyPantryTableViewCell
            {
                let indexPath = tableView.indexPath(for: selectedPantryItemCell)!
                let category = getCategories()[indexPath.section]
                let selectedPantryItem = category.pantryItems[indexPath.row]
                pantryItemDetailViewController.pantryItem = selectedPantryItem
                pantryItemDetailViewController.preSelectedCategoryName = category.name
                
            }
            
        }
        else if segue.identifier == "AddItem"
        {
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
 
    
}
