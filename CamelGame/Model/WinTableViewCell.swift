//
//  EndingTableViewCell.swift
//  CamelGame
//
//  Created by Katherine Brooks on 7/8/20.
//  Copyright © 2020 Katherine Brooks. All rights reserved.
//

import UIKit

class WinTableViewCell: UITableViewCell {

    @IBOutlet weak var winLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
