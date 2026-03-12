//
//  BikeDetailsModel.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 12/03/26.
//

import SwiftData
import Foundation

@Model
class CartModel {
    var id: String
    var bikeName: String
    var image: [String]
    var displacement: String
    var maxPower: String
    var kerbWeight: String
    var topSpeed: String
    var price: String
    var quantity: Double
    
    init(id: String, bikeName: String, image: [String], displacement: String, maxPower: String, kerbWeight: String, topSpeed: String, price: String, quantity: Double) {
        self.id = id
        self.bikeName = bikeName
        self.image = image
        self.displacement = displacement
        self.maxPower = maxPower
        self.kerbWeight = kerbWeight
        self.topSpeed = topSpeed
        self.price = price
        self.quantity = quantity
    }
}
