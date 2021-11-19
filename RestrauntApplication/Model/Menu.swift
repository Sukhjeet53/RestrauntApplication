//
//  NorthIndianMenu.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 17/11/21.
//

import Foundation
import UIKit

struct Menu {
    let name: String
    let price: Int
    let foodType: UIImage
    let foodImage: UIImage
}

let Menus: [String: [Menu]] = ["North Indian": [
    Menu(name: "Dal Makhani", price: 100, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "dalMakhani")!),
    Menu(name: "Chole Batture", price: 200, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "choleBatture")!),
    Menu(name: "Chicken Butter Masala", price: 300, foodType: UIImage(named: "nonveg")!, foodImage: UIImage(named: "chickenButterMasala")!),
    Menu(name: "Rajma", price: 400, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "rajma")!),
    Menu(name: "Sarso ka Saag", price: 500, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "sarsoKaSaag")!),
], "Chinese": [
    Menu(name: "Chow Mein", price: 100, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "chowmein")!),
    Menu(name: "Spring Roll", price: 200, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "springRoll")!),
    Menu(name: "Manchurian", price: 300, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "manchurian")!),
    Menu(name: "Drums of Heaven", price: 400, foodType: UIImage(named: "nonveg")!, foodImage: UIImage(named: "drumsOfHeaven")!),
    Menu(name: "Chilli Chicken", price: 500, foodType: UIImage(named: "nonveg")!, foodImage: UIImage(named: "chilliChicken")!)
], "Mexican": [
    Menu(name: "Quesadillas", price: 70, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "quesadillas")!),
    Menu(name: "Buritto", price: 150, foodType: UIImage(named: "nonveg")!, foodImage: UIImage(named: "buritto")!),
    Menu(name: "Nachos", price: 200, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "nachos")!),
    Menu(name: "Taco", price: 350, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "taco")!),
    Menu(name: "Carne Asada", price: 500, foodType: UIImage(named: "nonveg")!, foodImage: UIImage(named: "carneAsada")!)
], "South Indian": [
    Menu(name: "Uttapam", price: 70, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "uttapam")!),
    Menu(name: "Dosa", price: 150, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "dosa")!),
    Menu(name: "Idli", price: 200, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "idli")!),
    Menu(name: "Vada", price: 350, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "vada")!),
    Menu(name: "Rasam", price: 500, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "rasam")!)
], "Italian": [
    Menu(name: "Pizza", price: 70, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "pizza")!),
    Menu(name: "Pasta", price: 150, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "pasta")!),
    Menu(name: "Gelato", price: 200, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "gelato")!),
    Menu(name: "Lasagne", price: 350, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "lasagne")!),
    Menu(name: "Garlic Bread", price: 500, foodType: UIImage(named: "veg")!, foodImage: UIImage(named: "Garlic Bread")!)
]
]
