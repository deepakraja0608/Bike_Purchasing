//
//  TabbarView.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 06/03/26.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabbarView()
}
