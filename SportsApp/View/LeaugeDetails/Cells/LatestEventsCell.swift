//
//  LatestEventsCell.swift
//  SportsApp
//
//  Created by Andrew Emad on 03/02/2025.
//

import UIKit

class LatestEventsCell: UICollectionViewCell {
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rightTeamLabel: UILabel!
    @IBOutlet weak var leftTeamLabel: UILabel!
    @IBOutlet weak var rightTeamImg: UIImageView!
    @IBOutlet weak var LeftTeamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
