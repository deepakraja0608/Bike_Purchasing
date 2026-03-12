//
//  OrderPlacedAnimationView.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 07/03/26.
//

import SwiftUI
import SwiftData
import Lottie

struct OrderPlacedAnimationView: View {
    @Query var cart: [CartModel]
    @Environment(\.modelContext) var viewContext
    var close: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Text("Order Placed")
                    .font(.system(size: 22, weight: .bold))
                
                LottieView(animation: .named("success_check"))
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    .frame(width: 200, height: 200)
                    .onAppear {
                        for item in cart {
                            viewContext.delete(item)
                            try? viewContext.save()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            close?()
                        }
                    }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OrderPlacedAnimationView()
}
