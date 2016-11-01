//
//  CategoryItemsTableViewController.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/25/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import UIKit

class CategoryItemsTableViewController: UITableViewController {
    
    var category : PantryCategory?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = category?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        return (category?.getNumberOfPantryItems())!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CategoryItemsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryItemsTableViewCell

        let pantryItem = category?.pantryItems[indexPath.row]
        cell.pantryItemName.text = pantryItem?.name
        let amountRemaining = pantryItem?.amountRemainingInOunces ?? 0
        cell.pantryItemAmount.text = String(amountRemaining)
        cell.pantryItemUnit.text = pantryItem?.unit
        cell.pantryItemPhoto.image = pantryItem?.photo

        return cell
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToPantryItemList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MyPantryViewController, let pantryItem = sourceViewController.pantryItem {
            // Add a new pantryItem.
            let newIndexPath = IndexPath(row: (category?.getNumberOfPantryItems())!, section: 0)
            category?.addPantryItem(pantryItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            
            // TODO save this category
            category?.save()
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
            category?.removePantryItemAt(index: indexPath.row)
            category?.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
