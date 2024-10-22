//
//  DemoCollectionViewCell.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 18/10/24.
//

import UIKit

class DemoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "DemoCollectionViewCell"

    @IBOutlet weak var backgroundCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundCard.layer.cornerRadius = 10
//        backgroundCard.layer.shadowRadius = 2
//        backgroundCard.layer.shadowOpacity = 0.3
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "DemoCollectionViewCell", bundle: nil)
    }

    public func configure(with name: String, designation: String){
        titleLabel.text = name
        subTitleLabel.text = designation
    }
}
