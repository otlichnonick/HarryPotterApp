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
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Human.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Human.name, ascending: true)])
    var people: FetchedResults<Human>
    private var isFavorite: Bool {
        return people.contains(where: { $0.name == student.name })
    }
    @State var imageData: Data?
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
    private var star: String {
        isFavorite ? Constants.starFill : Constants.star
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemGray5))
                .cornerRadius(16)
            VStack {
                Text("This is a \(staffOrStudent) with name \(student.name)")
                    .font(.title)
                
                Image(uiImage: UIImage(data: imageData ?? Data()) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: Display.width * 0.5, height: Display.width * 0.5, alignment: .top)
                    .cornerRadius(16)
                
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
        .navigationBarItems(trailing: Button(action: {
            handleAction()
        }, label: {
            Image(systemName: star)
                .foregroundColor(.yellow)
        }))
        .onAppear {
            getImageData()
        }
    }
    
    private func addNewHuman() {
        let human = Human(context: managedObjectContext)
        human.name = student.name
        human.hogwartsStaff = student.hogwartsStaff
        human.gender = student.gender
        human.image = imageData
        let stick = Stick(context: managedObjectContext)
        stick.core = student.wand.core
        stick.wood = student.wand.wood
        stick.length = student.wand.length
        human.toStick = stick
        PersistenceController.shared.save()
    }
    
    private func handleAction() {
        if !isFavorite {
            addNewHuman()
        } else {
            if let human = people.first(where: { $0.name == student.name }),
               let stick = human.toStick {
                PersistenceController.shared.delete(object: human)
                PersistenceController.shared.delete(object: stick)
            }
        }
    }
    
    func getImageData() {
        guard let url = URL(string: student.image) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }
        task.resume()
    }
}

struct DetailInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailInfo(student: Student())
    }
}
