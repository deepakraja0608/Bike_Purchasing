//
//  Bike_PurchasingApp.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 15/01/26.
//

import SwiftUI
import SwiftData

@main
struct Bike_PurchasingApp: App {
    @StateObject private var router = NavigationRouter()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                ZStack {
                    if UserDefaults.standard.bool(forKey: "login_success") {
                        TabbarView()
                    } else {
                        LoginView()
                    }
                }
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                    case .home(_):
                        TabbarView()
                    case .register:
                        RegisterView()
                    case let .bikeDetails(bike):
                        BikeDetailsView(viewModel: BikeDetailsVM(bike: bike))
                    case .cart:
                        CartView()
                    case .profile:
                        ProfileView()
                    case .orderPlacedAnimated:
                        OrderPlacedAnimationView {
                            if let email = UserDefaults.standard.string(forKey: "email") {
                                router.path = [.home(email: email)]
                            }
                        }
                    }
                }
            }
            .environmentObject(router)
        }
        .modelContainer(for: [User.self, CartModel.self])
    }
}
