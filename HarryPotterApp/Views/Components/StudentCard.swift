//
//  StudentCard.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import GXUtilz

struct StudentCard: View {
    var student: Student
    private var birthday: String {
        student.dateOfBirth.isEmpty ? "n/a" : student.dateOfBirth
    }
    private var staffOrStudent: String {
        student.hogwartsStaff ? "Hogwarts staff" : "Hogwarts student"
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemGray5))
                .cornerRadius(16)
            HStack {
                WebImage(url: URL(string: student.image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: Display.width * 0.3, height: Display.width * 0.35, alignment: .top)
                    .cornerRadius(16)
                Spacer()
                VStack(alignment: .trailing, spacing: 8) {
                    InfoRow(title: "Name:", value: student.name)
                    InfoRow(title: "Status", value: staffOrStudent)
                    InfoRow(title: "Birthday", value: birthday)
                }
                .foregroundColor(.black)
                .font(.headline)
            }
            .padding()
        }
        .padding()
    }
}

struct StudentCard_Previews: PreviewProvider {
    static var previews: some View {
        StudentCard(student: Student())
    }
}
