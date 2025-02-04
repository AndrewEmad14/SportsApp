//
//  LeaugeDetailsCollectionViewCell.swift
//  SportsApp
//
//  Created by Andrew Emad on 03/02/2025.
//

import UIKit

class LeaugeDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rightTeam: UILabel!
    @IBOutlet weak var LeftTeam: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    
    @IBOutlet weak var leftImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
