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
    
        loadSampleCategories()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleCategories() {
        if let savedCategories = PantryCategory.loadCategories() {
            print("adding some saved categories")
            categories += savedCategories
        }
        else {
            print("Did not find any saved categories")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveCategories() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(categories, toFile: PantryCategory.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save categories...")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = categories[section]
        return category.getNumberOfPantryItems()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MyPantryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyPantryTableViewCell
        let category = categories[indexPath.section]
        let pantryItem = category.pantryItems[indexPath.row]
        
        cell.nameLabel.text = pantryItem.name
        cell.amountRemainingLabel.text = pantryItem.amountRemainingInOunces.description
        cell.unitLabel.text = pantryItem.unit
        cell.photoImageView.image = pantryItem.photo

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let category = categories[section]
        return "\(category.name)"
    }
    
    @IBAction func unwindToPantryItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MyPantryViewController, let pantryItem = sourceViewController.pantryItem {
            // Add a new pantryItem.
            let newIndexPath = IndexPath(row: categories[0].getNumberOfPantryItems(), section: 0)
            categories[0].addPantryItem(pantryItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            saveCategories()
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
