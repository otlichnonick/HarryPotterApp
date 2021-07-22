//
//  ContentView.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import SwiftUI
import GXUtilz

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Выбери факультет".uppercased())
                
                ForEach(viewModel.houses, id: \.self) { house in
                    NavigationLink(
                        destination: StudentList(viewModel: viewModel),
                        label: {
                            Text(house.rawValue)
                                    .frame(width: Display.width * 0.6, height: 40, alignment: .center)
                                    .foregroundColor(.black)
                                    .background(Color.green)
                                    .cornerRadius(10)
                        })
                        .simultaneousGesture(TapGesture().onEnded({ _ in
                            viewModel.house = house.rawValue
                            viewModel.getStudents()
                        }))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
