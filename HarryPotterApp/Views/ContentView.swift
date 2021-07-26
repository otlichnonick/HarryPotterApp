//
//  ContentView.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                HousesList()
            }
            .tabItem {
                Image(systemName: Constants.houseFill)
            }
            
            NavigationView {
                FavoriteList()
            }
            .tabItem {
                Image(systemName: Constants.starFill)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
