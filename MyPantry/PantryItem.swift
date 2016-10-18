//
//  PantryItem.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/18/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import Foundation
import UIKit

class PantryItem {
    // MARK: properties
    var name : String
    var amountRemainingInOunces : Float
    var photo : UIImage?
    
    init(name : String) {
        self.name = name
        self.amountRemainingInOunces = 0
        self.photo = nil
    }
    
    init(name : String, amountRemainingInOunces: Float) {
        self.name = name
        self.amountRemainingInOunces = 0
        self.photo = nil
    }
    
    init(name : String, amountRemainingInOunces: Float, photo : UIImage?) {
        self.name = name
        self.amountRemainingInOunces = amountRemainingInOunces
        self.photo = photo
    }
}
