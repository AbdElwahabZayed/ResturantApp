//
//  MenuItemTableViewCell.swift
//  AbdoEl7aty
//
//  Created by mac on 2/25/22.
//  Copyright © 2022 mac. All rights reserved.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
