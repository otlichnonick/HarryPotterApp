//
//  FavoriteItem.swift
//  HarryPotterApp
//
//  Created by Anton on 26.07.2021.
//

import SwiftUI

struct FavoriteItem: View {
    var human: Human
    private var staffOrStudent: String {
        human.hogwartsStaff ? "Hogwarts staff" : "Hogwarts student"
    }
    var body: some View {
        VStack {
            HStack {
                Text(human.name ?? "")
                .font(.title)
                Spacer()
            }

            HStack {
                Text(human.gender ?? "")
                Spacer()
                Text(staffOrStudent)
            }
            .font(.body)
        }
    }
}

struct FavoriteItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItem(human: Human())
    }
}
