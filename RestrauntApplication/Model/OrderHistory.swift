//
//  OrderHistory.swift
//  RestrauntApplication
//
//  Created by Sukhjeet  Singh on 18/11/21.
//

import Foundation

class orderHistory: NSObject, NSCoding{
    let orderID: String
    let foodItems: [food]
    let totalPrice: String
    
    init(orderID: String, items: [food], totalPrice: String) {
        self.orderID = orderID
        self.foodItems = items
        self.totalPrice = totalPrice
    }
    required init(coder decoder: NSCoder) {
        self.orderID = decoder.decodeObject(forKey: "orderID") as? String ?? ""
        self.foodItems = decoder.decodeObject(forKey: "foodItems") as? [food] ?? []
        self.totalPrice = decoder.decodeObject(forKey: "totalPrice") as? String ?? ""
    }
    func encode(with coder: NSCoder) {
        coder.encode(orderID, forKey: "orderID")
        coder.encode(foodItems, forKey: "foodItems")
        coder.encode(totalPrice, forKey: "totalPrice")
    }
}

class food: NSObject, NSCoding {
    let name: String
    let price: Int
    let number: Int
    
    init(name: String, price: Int, number: Int) {
        self.name = name
        self.price = price
        self.number = number
    }
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.price = decoder.decodeInteger(forKey: "price")
        self.number = decoder.decodeInteger(forKey: "number")
    }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(price, forKey: "price")
        coder.encode(number, forKey: "number")
    }
}
class Person: NSObject, NSCoding {
    let name: String
    let age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.age = decoder.decodeInteger(forKey: "age")
    }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(age, forKey: "age")
    }
}
