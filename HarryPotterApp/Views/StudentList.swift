//
//  StudentList.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import SwiftUI

struct StudentList: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            switch viewModel.loadState {
            case .loading:
                ProgressView("Download")
            case .success:
                list
            case .failure:
                Text(viewModel.errorMessage)
            }
        }
    }
}

extension StudentList {
    var list: some View {
        ScrollView {
            VStack {
                Text("Список студентов факультета \(viewModel.house)")
                ForEach(viewModel.students, id: \.name) { student in
                    NavigationLink(destination: DetailInfo(student: student)) {
                        StudentCard(student: student)
                    }
                }
            }
        }
    }
}

struct StudentList_Previews: PreviewProvider {
    static var previews: some View {
        StudentList(viewModel: ViewModel())
    }
}
