//
//  HousesList.swift
//  HarryPotterApp
//
//  Created by Anton on 22.07.2021.
//

import SwiftUI
import GXUtilz

struct HousesList: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
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

struct HousesList_Previews: PreviewProvider {
    static var previews: some View {
        HousesList()
    }
}
