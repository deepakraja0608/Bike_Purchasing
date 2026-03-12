//
//  HomeScreenView.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 12/02/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject var viewModel: HomeVM = HomeVM()
    @EnvironmentObject var router: NavigationRouter
    @Query var cartData: [CartModel]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 24) {
                        headerView
                        ForEach(viewModel.bikes) { bike in
                            BikeCollectionsCellView(bikeModel: bike)
                                .onTapGesture {
                                    router.path.append(.bikeDetails(bike))
                                }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(hex: "#B3CEE5").opacity(0.2)
                    .ignoresSafeArea()
            )
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    cartImageView
                        .overlay(cartCountView, alignment: .topTrailing)
                }
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

extension HomeView {
    @ViewBuilder
    var cartCountView: some View {
        if cartData.count > 0 {
            Text("\(cartData.count)")
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

extension HomeView {
    @ViewBuilder
    var headerView: some View {
        HStack {
            Text("Bikes")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            profileIconView
        }
        .padding()
    }
    
    @ViewBuilder
    var profileIconView: some View {
        Button {
            router.path.append(.profile)
        } label: {
          Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(Color.black)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}


        
struct BikeCollectionsCellView: View {
    var bikeModel: BikeModel
    var isShowMultiBikeImages: Bool = false
    var isFromDetailsScreen: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                if isShowMultiBikeImages {
                    TabView {
                        ForEach(0..<bikeModel.image.count, id: \.self) { index in
                            let image = bikeModel.image[index]
                            imageView(imageStr: image)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                } else {
                    imageView(imageStr: bikeModel.image.first ?? "")
                }
               
            }
            .frame(maxWidth: .infinity, minHeight: 200)
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 15) {
                contentCell(value: bikeModel.bikeName, size: 24)
                if isFromDetailsScreen {
                    contentCell(value: bikeModel.topSpeed)
                    contentCell(value: bikeModel.kerbWeight)
                    contentCell(value: bikeModel.maxPower)
                    contentCell(value: bikeModel.price)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    func imageView(imageStr: String) -> some View {
        if let url = URL(string: imageStr) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .clipped()
            .cornerRadius(12)
        }
    }
    
    func addCardBtnView() -> some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "minus")
                
                Text("Add Cart")
                  
                Image(systemName: "plus")
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(
                Color(hex: "#FF6473")
                    .cornerRadius(10)
            )
        }
    }
    
    
    func contentCell(value: String, size: CGFloat = 16) -> some View {
        HStack {
            Text(value)
                .font(.system(size: size, weight: .medium))
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(NavigationRouter())
}
