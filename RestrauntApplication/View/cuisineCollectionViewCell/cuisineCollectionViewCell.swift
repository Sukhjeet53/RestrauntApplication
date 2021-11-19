//
//  cuisineCollectionViewCell.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import UIKit

class cuisineCollectionViewCell: UICollectionViewCell {
    ///Identifier for Cell
    static var identifier = "cuisineCollectionViewCell"
    
    ///NibName for Cell
    static var nibName = UINib(nibName: "cuisineCollectionViewCell", bundle: nil)
    
    
    @IBOutlet weak var cuisineName: UILabel!
    @IBOutlet weak var cuisineImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization cell
        self.layer.cornerRadius = 10
        cuisineImage.layer.borderColor = CGColor(gray: 1, alpha: 1)
        cuisineImage.layer.borderWidth = 2
    }
    
    //Initializing Cell
    func commonInit(label: String, image: UIImage) {
        cuisineName.text = label
        cuisineImage.image = image
    }

}
