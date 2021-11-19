//
//  MenuViewController.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var MenuTableView: UITableView!
    @IBOutlet weak var selectedItemsLabel: UILabel!
    
    var cuisineName = ""
    var menuForSelectedVC = [Menu]()
    
    var totalItem = 0
    var totalPrice = 0
    var selectedItem = [String: (Menu, Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Registering cell for table
        MenuTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        ///Setting Delegate, DataSource for MenuTableView
        MenuTableView.delegate = self
        MenuTableView.dataSource = self
        
        ///Setting Title for ViewController
        cuisineName = title!
        
        menuForSelectedVC = Menus[cuisineName]!
    }
    
    //Adds a Observer for Notification name "countChanged", it starts listening for notification when View will Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleCountChanges), name: .countChanged, object: nil)
    }
    
    //Removes Obeserver when view disappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //Handling changes in count
    @objc func handleCountChanges(notification: Notification) {
        
        let selectedMenuCell = notification.object as! MenuTableViewCell
        
        let count = selectedMenuCell.incdec
        
        let menuItem: Menu = Menu(name: selectedMenuCell.foodName.text!, price: Int(selectedMenuCell.price.text!.replacingOccurrences(of: "Rs.", with: "")) ?? 0, foodType: selectedMenuCell.foodType.image!, foodImage: selectedMenuCell.foodImage.image!)
        
        totalItem += count
        
        let price = selectedMenuCell.price.text!.replacingOccurrences(of: "Rs.", with: "")
        
        if selectedItem[selectedMenuCell.foodName.text!] == nil {
            selectedItem[selectedMenuCell.foodName.text!] = (menuItem, 1)
            totalPrice += Int(price)!
        }
        else {
            if count < 0 {
                totalPrice -= Int(price)!
                selectedItem[selectedMenuCell.foodName.text!]!.1 -= 1
                
            } else {
                totalPrice += Int(price)!
                selectedItem[selectedMenuCell.foodName.text!]!.1 += 1
            }
        }
        
        selectedItemsLabel.text = "\(totalItem) Items Selected (Rs.\(totalPrice))"
    }
    
    //Action when Go to Cart Button Pressed
    @IBAction func goToCart(_ sender: UIButton) {
        ///Checking if TotalItem and TotalPrice is 0
        if totalItem == 0 && totalPrice == 0 {
            return
        }
        ///List of Food Selected from Menu
        var listOfFood = [(Menu, Int)]()
        
        let keys = selectedItem.keys
        
        for key in keys {
            if selectedItem[key]!.1 == 0 {
                continue
            }
            listOfFood.append(selectedItem[key]!)
        }
        
        ///Going to Summary VC when go to cart pressed
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        vc.title = "Cart"
        vc.commonInit(selectedItemFromMenu: listOfFood)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: TableView Delegate, DataSource
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Number of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuForSelectedVC.count
    }
    
    //Setting cells for TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        
        let foodForCell = menuForSelectedVC[indexPath.row]
        
        cell.commonInit(foodImage: foodForCell.foodImage, foodName: foodForCell.name, foodPrice: String(foodForCell.price), foodType: foodForCell.foodType)
        
        return cell
    }
    
    //Setting Height for cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

// MARK: Extension for Notification Name "countChanged"
extension Notification.Name {
    static let countChanged = Notification.Name(rawValue: "countChanged")
}
