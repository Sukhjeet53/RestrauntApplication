//
//  SummaryViewController.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import UIKit
import CoreData
class SummaryViewController: UIViewController {
    
    @IBOutlet weak var summaryTableView: UITableView!
    
    var selectedFoodItems = [(Menu, Int)]()
    
    //Initializing selectedFoodItems
    func commonInit(selectedItemFromMenu: [(Menu, Int)]) {
        selectedFoodItems = selectedItemFromMenu
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Registering cells for Table
        summaryTableView.register(CartTableViewCell.nibName, forCellReuseIdentifier: CartTableViewCell.identifier)
        
        //////Setting Delegate, DataSource for summaryTableView
        summaryTableView.delegate = self
        summaryTableView.dataSource = self
    }
    
    //Function for Creating Random Int of length 5, then converting to String
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
            number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    
    //When Order Button is Pressed
    @IBAction func Order(_ sender: UIButton) {
        
        var price = 0
        
        var OrderList = [orderHistory]()
        
        for item in selectedFoodItems {
            price += item.0.price * item.1
        }
        
        let orderID = random(digits: 5)
        
        var foodList: [food] = [] as! [food]
        
        for foodItem in selectedFoodItems {
            let name = foodItem.0.name
            let price = foodItem.0.price
            let quantity = foodItem.1
            let foodItem = food(name: name, price: price, number: quantity)
            foodList.append(foodItem)
        }
        
        let order: orderHistory = orderHistory(orderID: orderID, items: foodList, totalPrice: String(price))
        
        //Updating OrderList
        OrderList.append(order)
        
        //Retreiving Data from UserDefault for key "orders"
        do {
            if let data = UserDefaults.standard.data(forKey: "orders"), let OrderListFromUserDefault = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [orderHistory] {
                for order in OrderListFromUserDefault {
                    OrderList.append(order)
                }
            }
        }catch{
            print(error)
        }
    
        OrderSummary(OrderList: OrderList)
        
        NotificationCenter.default.post(name: .orderBooked, object: order)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Function for storing Order's List in UserDefault
    func OrderSummary(OrderList:[orderHistory]){
        
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: OrderList, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "orders")
        } catch {
            print(error)
        }
        
    }
    
}

// MARK: TableView Delegate, DataSource
extension SummaryViewController:UITableViewDelegate,UITableViewDataSource{
    
    //Setting number of Section in TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //Setting number of Rows for a Section in TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return selectedFoodItems.count
        } else {
            return 1
        }
    }
    
    //Setting Cells for TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///Order Section Cells
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
            let quantity = "\(selectedFoodItems[indexPath.row].0.name) × \(selectedFoodItems[indexPath.row].1)"
            let price = selectedFoodItems[indexPath.row].0.price * selectedFoodItems[indexPath.row].1
            cell.commonInit(price: String(price), quantity: quantity)
            return cell
        }
        ///Total Section Cell
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
            var price = 0
            for item in selectedFoodItems {
                price += item.0.price * item.1
            }
            cell.commonInit(price: String(price), quantity: "Total")
            cell.backgroundColor = .lightGray
            return cell
        }
    }
    
    //Setting Height for cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
