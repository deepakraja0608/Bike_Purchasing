//
//  BikeDetailsView.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 16/02/26.
//

import SwiftUI
import SwiftData

struct BikeDetailsView: View {
    @StateObject var viewModel: BikeDetailsVM
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.modelContext) private var context
    @Query var cartItem: [CartModel]
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 24) {
                        BikeCollectionsCellView(
                            bikeModel: viewModel.bike,
                            isShowMultiBikeImages: true,
                            isFromDetailsScreen: true
                        )
                    }
                }
                addItemButtonView
            }
        }
        .background(Color(hex: "#B3CEE5").opacity(0.2))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                cartImageView
                    .overlay(cartCountView, alignment: .topTrailing)
            }
        }
    }
    
    var cartImageView: some View {
        Button {
            router.path.append(.cart)
        } label: {
            Image(systemName: "cart.fill")
                .resizable()
                .frame(width: 18, height: 18)
                .frame(width: 35, height: 35)
                .scaledToFit()
        }
    }
}

extension BikeDetailsView {
    @ViewBuilder
    var cartCountView: some View {
        if cartItem.count > 0 {
            Text("\(cartItem.count)")
                .font(.system(size: 10))
                .foregroundColor(Color.white)
                .padding(.vertical, 2)
                .padding(.horizontal, 5)
                .background(
                    Color(hex: "#FF6473")
                        .cornerRadius(20)
                )
        }
    }
}

extension BikeDetailsView {
    @ViewBuilder
    var addItemButtonView: some View {
        let isAlreadyAdded = cartItem.contains(where: {$0.id == viewModel.bike.id})
        Button {
            if !isAlreadyAdded {
                addToCartAction()
            } else {
                router.path.append(.cart)
            }
        } label: {
            HStack {
                Image(systemName: "cart.fill")
                Text(!isAlreadyAdded ? "Add to cart" : "Go to cart")
                    .font(.system(size: 16, weight: .bold))
            }
            .foregroundColor(isAlreadyAdded ? Color(hex: "#FF6473") : Color.white)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(
                Color(hex: !isAlreadyAdded ? "#FF6473" : "#FFFFFF")
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: "#FF6473"), lineWidth: 1)
                            .opacity(isAlreadyAdded ? 1 : 0)
                    )
            )
        }
        .padding(.horizontal, 24)
    }
    
    func addToCartAction() {
        let bike = viewModel.bike
        let cart = CartModel(id: bike.id, bikeName: bike.bikeName, image: bike.image, displacement: bike.displacement, maxPower: bike.maxPower, kerbWeight: bike.kerbWeight, topSpeed: bike.topSpeed, price: bike.price, quantity: 1)
        context.insert(cart)
        
        //try? context.save()
        
        let fetch = cartItem
        
        debugPrint("cartItem--->", cartItem.count)
    }
}

//#Preview {
//    BikeDetailsView(viewModel: BikeDetailsVM(bike: BikeModel(bikeName: "", image: [], displacement: "", maxPower: "", kerbWeight: "", topSpeed: "", price: "")), cartItem: <#CartModel#>)
//}
