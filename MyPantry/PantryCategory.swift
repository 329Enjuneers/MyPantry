//
//  Category.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/19/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import Foundation
import UIKit

class PantryCategory {
    
    // MARK: Properties
    var name : String
    var description : String
    var pantryItems : [PantryItem]
    
    init(_ name : String, description : String?="") {
        self.name = name
        self.description = description!
        self.pantryItems = []
    }
    
    func addPantryItem(_ item : PantryItem) {
        pantryItems.append(item)
    }
    
    func getNumberOfPantryItems() -> Int{
        return pantryItems.count
    }
    
    func addDefaultPantryItem1() {
        let flourImage = UIImage(named : "flour")
        let flour = PantryItem(name: "Flour", amountRemainingInOunces: 250, photo: flourImage, unit : "oz")
        addPantryItem(flour)
    }
    
    func addDefaultPantryItem2() {
        let cerealImage = UIImage(named: "fruity-pebbles")
        let cereal = PantryItem(name: "Fruity Pebbles", amountRemainingInOunces: 500, photo: cerealImage, unit: "oz")
        addPantryItem(cereal)
    }
    
    func getDisplayableDescription() -> String {
        var displayableDescription = description
        if description != "" {
            displayableDescription = "- " + description
        }
        return displayableDescription
    }
}
