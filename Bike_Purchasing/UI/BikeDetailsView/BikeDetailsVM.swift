//
//  BikeDetailsVM.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 16/02/26.
//

import Foundation

class BikeDetailsVM: ObservableObject {
    @Published var bike: BikeModel
    
    init(bike: BikeModel) {
        self.bike = bike
    }
}
