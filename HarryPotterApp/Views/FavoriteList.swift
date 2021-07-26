//
//  FavoriteList.swift
//  HarryPotterApp
//
//  Created by Anton on 22.07.2021.
//

import SwiftUI

struct FavoriteList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Human.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Human.name, ascending: true)])
    var people: FetchedResults<Human>
    
    var body: some View {
        if people.isEmpty {
            VStack {
            Text("Пока список пуст, вы можете добавить в него кого-нибудь!")
                .font(.headline)
                Spacer()
            }
        } else {
            List {
                ForEach(people) { human in
                    NavigationLink(destination: DetailInfo(imageData: createImageData(from: human), student: createStudent(from: human))) {
                        FavoriteItem(human: human)
                    }
                }
                .onDelete(perform: removeItem)
            }
        }
    }
    private func removeItem(at offsets: IndexSet) {
        for index in offsets {
            let human = people[index]
            managedObjectContext.delete(human)
            if let stick = human.toStick {
            managedObjectContext.delete(stick)
            }
        }
    }
    
    private func createStudent(from human: Human) -> Student {
        var student = Student()
        student.name = human.name ?? ""
        student.gender = human.gender ?? ""
        student.hogwartsStaff = human.hogwartsStaff
        let stick = human.toStick
        student.wand = Wand(wood: stick?.wood ?? "", core: stick?.core ?? "", length: stick?.length ?? "")
        return student
    }
    
    private func createImageData(from human: Human) -> Data? {
        return human.image
    }
}

struct FavoriteList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
