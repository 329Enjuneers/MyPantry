//
//  Category.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/19/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import Foundation
import UIKit

class PantryCategory: NSObject, NSCoding {
    
    // MARK: Properties
    var name : String
    var theDescription : String
    var pantryItems : [PantryItem]
    
    struct PropertyKey {
        static let nameKey = "name"
        static let descriptionKey = "theDescription"
        static let pantryItemKeys = "pantryItems"
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("categories")
    
    init(_ name : String, theDescription : String?="", pantryItems : [PantryItem]?=[]) {
        self.name = name
        self.theDescription = theDescription!
        self.pantryItems = pantryItems!
        
        super.init()
    }
    
    static func loadCategories() -> [PantryCategory]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ArchiveURL.path) as? [PantryCategory]
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
        var displayableDescription = theDescription
        if theDescription != "" {
            displayableDescription = "- " + theDescription
        }
        return displayableDescription
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(theDescription, forKey: PropertyKey.descriptionKey)
        aCoder.encode(pantryItems, forKey: PropertyKey.pantryItemKeys)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey:PropertyKey.nameKey) as! String
        let description = aDecoder.decodeObject(forKey: PropertyKey.descriptionKey) as? String
        let pantryItems = aDecoder.decodeObject(forKey: PropertyKey.pantryItemKeys) as? [PantryItem]
        self.init(name, theDescription : description, pantryItems : pantryItems)
    }
}
