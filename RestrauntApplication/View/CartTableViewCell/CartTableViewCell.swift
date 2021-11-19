//
//  CartTableViewCell.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    ///Identifer for Cell
    static var identifier = "CartTableViewCell"
    ///NibName for Cell
    static var nibName = UINib(nibName: "CartTableViewCell", bundle: nil)

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var foodQuantity: UILabel!
    
    //Initializing Cell
    func commonInit(price: String, quantity: String) {
        totalPriceLabel.text = price
        foodQuantity.text = quantity
    }
    
}
