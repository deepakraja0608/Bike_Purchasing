//
//  HomeVM.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 16/02/26.
//

import Foundation

class HomeVM: ObservableObject {
    @Published var bikes: [BikeModel] = []
    
    init() {
        bikes = loadBikes()
    }
    // 👇 Function outside body
    func loadBikes() -> [BikeModel] {
        guard let url = Bundle.main.url(forResource: "bikes", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let bikes = try? JSONDecoder().decode([BikeModel].self, from: data) else {
            print("invalid")
            return []
        }
        
        return bikes
    }
}
