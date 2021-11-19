//
//  MenuTableViewCell.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    ///Identifier for Cell
    static var identifier = "MenuTableViewCell"
    
    ///NibName for Cell
    static var nibName = UINib(nibName: "MenuTableViewCell", bundle: nil)
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var foodType: UIImageView!
    @IBOutlet weak var foodCount: UILabel!
    
    //Variable for checking if Counter is Incremented or Decremented
    var incdec = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization Cell
        foodImage.layer.borderWidth = 2
        foodImage.layer.borderColor = CGColor(gray: 0.5, alpha: 1)
        foodImage.layer.cornerRadius = 10
    }

    //Initialzing Cell
    func commonInit(foodImage: UIImage, foodName: String, foodPrice: String, foodType: UIImage) {
        self.foodImage.image = foodImage
        self.foodImage.contentMode = .scaleToFill
        
        self.foodName.text = foodName
        self.foodName.contentMode = .scaleToFill
        
        price.text = "Rs." + foodPrice
        price.contentMode = .scaleToFill
        
        self.foodType.image = foodType
        self.foodType.contentMode = .scaleToFill
    }
    
    //Counter for a Food Item
    @IBAction func counter(_ sender: UIStepper) {
        ///Checking for increment or decrement in counter's value
        if Int(foodCount.text ?? "0")! < Int(sender.value) {
            incdec = 1
        } else {
            incdec = -1
        }
        foodCount.text = String(Int(sender.value))
        
        ///Posting Notification that value of counter has been changed
        NotificationCenter.default.post(name: .countChanged, object: self)
    }
}
