//
//  TopRatedTableViewCell.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import UIKit

class TopRatedTableViewCell: UITableViewCell {
    ///Identifier for Cell
    static var identifier = "TopRatedTableViewCell"
    ///NibName for Cell
    static var nibName = UINib(nibName: "TopRatedTableViewCell", bundle: nil)

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var pricingLabel: UILabel!
    @IBOutlet weak var type: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        ///Initialization Cell
        foodImage.layer.cornerRadius = 10
        foodImage.layer.borderColor = CGColor(gray: 0.5, alpha: 1)
        foodImage.layer.borderWidth = 2
    }
    
    //Initializing Cell
    func commonInit(foodImage: UIImage, foodType: UIImage,foodLabel: String, ratingLabel: String, price: String) {
        self.foodImage.image = foodImage
        self.foodImage.contentMode = .scaleToFill
        self.foodLabel.text = foodLabel
        self.pricingLabel.text = "Rs."+price
        self.ratingLabel.text = ratingLabel
        self.type.image = foodType
        self.type.contentMode = .scaleToFill
    }
    
}
