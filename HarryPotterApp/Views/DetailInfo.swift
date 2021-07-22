//
//  DetailInfo.swift
//  HarryPotterApp
//
//  Created by Anton on 22.07.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import GXUtilz

struct DetailInfo: View {
    var student: Student
    private var staffOrStudent: String {
        student.hogwartsStaff ? "Hogwarts staff" : "Hogwarts student"
    }
    private var gender: String {
        student.gender == "male" ? "He" : "She"
    }
    private var wood: String {
        student.wand.wood.isEmpty ? "n/a" : student.wand.wood
    }
    private var core: String {
        student.wand.core.isEmpty ? "n/a" : student.wand.core
    }
    private var length: String {
        student.wand.length.isEmpty ? "n/a" : student.wand.length
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemGray5))
                .cornerRadius(16)
            VStack {
                Text("This is a \(staffOrStudent) with name \(student.name)")
                    .font(.title)
                
                HStack {
                    WebImage(url: URL(string: student.image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: Display.width * 0.5, height: Display.width * 0.5, alignment: .top)
                        .cornerRadius(16)
                }
                
                Group {
                    Text("\(gender) has the wand with properties:")
                        .padding(.bottom, 20)
                    InfoRow(title: "wood:", value: wood)
                    InfoRow(title: "core", value: core)
                    InfoRow(title: "lenght", value: length)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct DetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailInfo(student: Student())
    }
}
