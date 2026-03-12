//
//  ProfileView.swift
//  Bike_Purchasing
//
//  Created by Guru  Mahan on 04/03/26.
//

import SwiftUI
import _SwiftData_SwiftUI

struct ProfileView: View {
    @Query private var users: [User]
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 30) {
                    headerView
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            userDetails(title: "Name:", value: userDetail()?.username ?? "")
                            userDetails(title: "Email:", value: userDetail()?.email ?? "")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        logoutView
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color(hex: "#B3CEE5").opacity(0.2)
                    .ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        HStack {
            Text("Profile")
                .font(.system(size: 24, weight: .bold))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func userDetails(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            Text(value)
        }
    }
}

extension ProfileView {
    func userDetail() -> User? {
        let email: String =   UserDefaults.standard.string(forKey: "email") ?? ""
        return users.filter({$0.email == email}).first
    }
}

extension ProfileView {
    @ViewBuilder
    var logoutView: some View {
        Text("Log out")
            .bold()
            .foregroundColor(Color.red)
            .onTapGesture {
                UserDefaults.standard.set("", forKey: "email")
                UserDefaults.standard.set(false, forKey: "login_success")
                router.path = [.login]
            }
            .padding(.trailing)
            .padding(.top, 50)
    }
}

#Preview {
    ProfileView()
}
