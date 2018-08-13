//
//  ScoreTableViewCell.swift
//  colorMagic
//
//  Created by Anthony on 7/12/2017.
//  Copyright © 2017 AntmanTech. All rights reserved.
//

import UIKit

// The high scores table must be displayed as a proper table with three columns: Rank, Name, and Score
class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        rankLbl.textColor = .darkGray
        scoreLbl.textColor = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
