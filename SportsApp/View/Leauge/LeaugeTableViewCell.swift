//
//  LeaugeTableViewCell.swift
//  SportsApp
//
//  Created by Andrew Emad on 31/01/2025.
//

import UIKit

class LeaugeTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
