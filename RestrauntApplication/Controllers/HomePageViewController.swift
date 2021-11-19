//
//  HomePageViewController.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import UIKit

class HomePageViewController: UIViewController{
    
    @IBOutlet weak var cuisineCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var TopRatedTableView: UITableView!
    
    ///Dummy data for TopRated Food list
    let TopRatedFoods: [TopRated] = [
        TopRated(name: "Chole Batture", foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "choleBatture")!, price: 200, rating: "4.2"),
        TopRated(name: "Pasta", foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "chowmein")!, price: 200, rating: "4.1"),
        TopRated(name: "Chilli Chicken", foodType: UIImage(named: "nonveg")!, foodImage: UIImage(named: "chilliChicken")!, price: 500, rating: "4.0")
    ]
    
    ///Name for Cuisines
    let Cuisines: [Cuisine] = [
        Cuisine(name: "Italian"),
        Cuisine(name: "North Indian"),
        Cuisine(name: "Chinese"),
        Cuisine(name: "Mexican"),
        Cuisine(name: "South Indian"),
        Cuisine(name: "Italian"),
        Cuisine(name: "North Indian")
    ]
    
    ///Name for headers
    let headers = ["Top Rated", "Order History"]
    
    ///Intialising orders List
    var orders: [orderHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Setting Delegate, DataSource for cuisineCategory CollectionView
        cuisineCategoryCollectionView.delegate = self
        cuisineCategoryCollectionView.dataSource = self
        
        ///Setting Delegate, DataSource for TopRated TableView
        TopRatedTableView.delegate = self
        TopRatedTableView.dataSource = self
        
        ///Registering cell for collection view
        cuisineCategoryCollectionView.register(cuisineCollectionViewCell.nibName, forCellWithReuseIdentifier: cuisineCollectionViewCell.identifier)
        ///Registering cells for table super.viewDidLoad()
        TopRatedTableView.register(TopRatedTableViewCell.nibName, forCellReuseIdentifier: TopRatedTableViewCell.identifier)
        TopRatedTableView.register(orderHistoryTableViewCell.nibName, forCellReuseIdentifier: orderHistoryTableViewCell.identifier)
        
        ///Checking if there is any previous orders stored in UserDefaults
        do{
            if let data = UserDefaults.standard.data(forKey: "orders"), let orders = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [orderHistory] {
                orders.forEach({print($0.orderID, $0.foodItems, $0.totalPrice)})
                self.orders = orders
            }
        } catch {
            print(error)
        }
        TopRatedTableView.reloadData()
        self.cuisineCategoryCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
    }
    
    //Adds a Observer for Notification name "orderBooked", it starts listening for notification when View will Appear
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrderBooking), name: .orderBooked, object: nil)
    }
    
    ///Handling OrderBooking when user taps book order at SummaryViewCOntroller
    @objc func handleOrderBooking(notification: Notification) {
        let order = notification.object as! orderHistory
        
        orders.append(order)
        TopRatedTableView.reloadData()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

// MARK: CollectionView Delegate, DataSource
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout ,UIScrollViewDelegate{
    
    //Number of Cells in a Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cuisines.count
    }
    
    //Setting Cells for a Collection View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cuisineCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: cuisineCollectionViewCell.identifier, for: indexPath) as! cuisineCollectionViewCell
        
        cell.commonInit(label: Cuisines[indexPath.row].name, image: UIImage(named: Cuisines[indexPath.row].name)!)
        return cell
    }
    
    //Action if a cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.title = Cuisines[indexPath.row].name
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //Setting Size for a cell in Collection View
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cuisineCategoryCollectionView.frame.width, height: cuisineCategoryCollectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == cuisineCategoryCollectionView{
            let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
            let pageInt = Int(round(pageFloat))
            
            switch pageInt {
            case 0:
                cuisineCategoryCollectionView.scrollToItem(at: [0, 5], at: .centeredHorizontally, animated: false)
            case Cuisines.count - 1:
                cuisineCategoryCollectionView.scrollToItem(at: [0, 1], at: .centeredHorizontally, animated: false)
            default:
                break
            }
        }
    }
}


// MARK: TableView Delegate, DataSource
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Number of Section of a Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //Number of Rows in a Section of a Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return TopRatedFoods.count
        case 1: return orders.count
        default: return 0
        }
    }
    
    //Setting Cells for Table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// For Top Rated Section
        if indexPath.section == 0 {
            let cell = TopRatedTableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.identifier, for: indexPath) as! TopRatedTableViewCell
            let food = TopRatedFoods[indexPath.row]
            cell.commonInit(foodImage: food.foodImage, foodType: food.foodType, foodLabel: food.name, ratingLabel: food.rating, price: String(food.price))
            return cell
        }
        ///For Order History Section
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: orderHistoryTableViewCell.identifier, for: indexPath) as! orderHistoryTableViewCell
            cell.commonInit(orderHistory: orders[indexPath.row])
            return cell
        }
    }
    
    //Setting Height For Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 86
        } else {
            return 250
        }
    }
    
    //Setting Title For Headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
}

// MARK: Extension for Notification Name "Order Booked"
extension Notification.Name {
    static let orderBooked = Notification.Name(rawValue: "orderBooked")
}
