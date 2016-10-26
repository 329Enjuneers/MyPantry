//
//  CategoryItemsTableViewCell.swift
//  MyPantry
//
//  Created by Joseph.McGovern on 10/25/16.
//  Copyright © 2016 Joseph.McGovern. All rights reserved.
//

import UIKit

class CategoryItemsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var pantryItemPhoto: UIImageView!
    @IBOutlet weak var pantryItemName: UILabel!
    @IBOutlet weak var pantryItemAmount: UILabel!
    @IBOutlet weak var pantryItemUnit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
