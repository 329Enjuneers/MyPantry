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
    var unit : String
    
    init(name : String, amountRemainingInOunces: Float, photo : UIImage?, unit : String) {
        self.name = name
        self.amountRemainingInOunces = amountRemainingInOunces
        self.photo = photo
        self.unit = unit
    }
}
