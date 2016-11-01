//
//  PantryItem.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/18/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import Foundation
import UIKit

class PantryItem: NSObject, NSCoding {
    
    // MARK: properties
    var name : String
    var amountRemainingInOunces : Float
    var photo : UIImage?
    var unit : String
    
    struct PropertyKey {
        static let nameKey = "name"
        static let amountRemainingInOuncesKey = "amountRemainingInOunces"
        static let photoKey = "photo"
        static let unitKey = "unit"
    }
    
    init(name : String, amountRemainingInOunces: Float, photo : UIImage?, unit : String) {
        self.name = name
        self.amountRemainingInOunces = amountRemainingInOunces
        self.photo = photo
        self.unit = unit
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(amountRemainingInOunces, forKey: PropertyKey.amountRemainingInOuncesKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(unit, forKey: PropertyKey.unitKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey:PropertyKey.nameKey) as! String
        _ = aDecoder.decodeObject(forKey: PropertyKey.amountRemainingInOuncesKey)
        let amountRemainingInOunces = aDecoder.decodeFloat(forKey: PropertyKey.amountRemainingInOuncesKey)
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        let unit = aDecoder.decodeObject(forKey: PropertyKey.unitKey) as! String
        self.init(name: name, amountRemainingInOunces : amountRemainingInOunces, photo : photo, unit : unit)
    }
}
