//
//  HomeScreenModel.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 13/02/26.
//

import Foundation

struct BikeModel: Identifiable, Hashable, Codable {
    var id: String
    let bikeName: String
    let image: [String]
    let displacement: String
    let maxPower: String
    let kerbWeight: String
    let topSpeed: String
    let price: String
    var quantity: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case bikeName = "bike_Name"
        case image
        case displacement
        case maxPower = "max_power"
        case kerbWeight = "kerb_weight"
        case topSpeed = "top_speed"
        case price
    }
    
    init(
        id: String,
        bikeName: String,
        image: [String],
        displacement: String,
        maxPower: String,
        kerbWeight: String,
        topSpeed: String,
        price: String,
        quantity: Double
    ) {
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
