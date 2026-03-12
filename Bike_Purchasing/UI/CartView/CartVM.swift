//
//  CartVM.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 04/03/26.
//

import SwiftData
import SwiftUI

class CartVM: ObservableObject {
  
    func deleteData(context: ModelContext, item: CartModel) {
        context.delete(item)
        try? context.save()
    }
    
    func formatDecimalValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = value.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    func formatDecimalValue(_ value: String) -> String {
        
        // Remove commas
        let cleanValue = value.replacingOccurrences(of: ",", with: "")
        
        guard let doubleValue = Double(cleanValue) else {
            return "Invalid Number"
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = doubleValue.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 2
        
        return formatter.string(from: NSNumber(value: doubleValue)) ?? ""
    }
}
