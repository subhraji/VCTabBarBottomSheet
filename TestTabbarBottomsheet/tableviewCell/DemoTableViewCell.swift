//
//  DemoTableViewCell.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 15/10/24.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    static let identifier = "DemoTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
