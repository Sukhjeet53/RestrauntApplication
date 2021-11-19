//
//  orderHistoryTableViewCell.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 18/11/21.
//

import UIKit

class orderHistoryTableViewCell: UITableViewCell {
    ///Identifier for Cell
    static let identifier = "orderHistoryTableViewCell"
    ///NibName for Cell
    static let nibName = UINib(nibName: "orderHistoryTableViewCell", bundle: nil)

    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var foodItemsTable: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    //List of Food Items that are being added to cart
    var foodItems: [food] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTable()
    }
    
    //Setting TableView for Cell
    func setupTable() {
        self.layer.cornerRadius = 10
        foodItemsTable.layer.cornerRadius = 10
        
        ///Setting Delegate, DataSource for foodItems TableView
        foodItemsTable.delegate = self
        foodItemsTable.dataSource = self
        
        ///Registering Cell for Cart TableView
        foodItemsTable.register(CartTableViewCell.nibName, forCellReuseIdentifier: CartTableViewCell.identifier)
    }
    
    //Initializing Cell
    func commonInit(orderHistory: orderHistory) {
        totalPrice.text = "Rs.\(orderHistory.totalPrice)"
        orderIDLabel.text! = "Order ID :\(orderHistory.orderID)"
        foodItems = orderHistory.foodItems
    }
}

// MARK: TableView Delegate, DataSource
extension  orderHistoryTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    //Setting Number of Rows in Section for TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    //Setting Cell for TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        
        let food = foodItems[indexPath.row]
        
        let quantity = "\(food.name) * \(food.number)"
        
        let price = food.price * food.number
        
        cell.commonInit(price: "Rs.\(price)", quantity: quantity)
        
        return cell
    }
    
    
}
