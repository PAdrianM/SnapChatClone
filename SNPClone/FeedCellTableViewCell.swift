//
//  FeedCellTableViewCell.swift
//  SNPClone
//
//  Created by Andrea Hernandez on 1/17/24.
//

import UIKit

class FeedCellTableViewCell: UITableViewCell {

    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedUserLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
