//
//  InfoRow.swift
//  HarryPotterApp
//
//  Created by Anton on 22.07.2021.
//

import SwiftUI

struct InfoRow: View {
    var title: String
    var value: String
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.body)
                Spacer()
            }
            HStack {
                Spacer()
                Text(value)
                    .font(.headline)
            }
        }
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(title: "Name", value: "Dranco Malfoy")
    }
}
