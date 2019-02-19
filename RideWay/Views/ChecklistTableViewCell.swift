//
//  ChecklistTableViewCell.swift
//  RideWay
//
//  Created by Thomas Cowern New on 2/17/19.
//  Copyright © 2019 Thomas Cowern New. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {
    @IBOutlet weak var checklistCellSwitch: UISwitch!
    @IBOutlet weak var checklistCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
