//
//  ViewModel.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var house = ""
    @Published var loadState = LoadState.loading
    var houses = Houses.allCases
    var errorMessage = ""
    var students = [Student]()
}

extension ViewModel {
    func getStudents() {
        students = []
        loadState = .loading
        guard let url = URL(string: Constants.baseUrl + house.lowercased()) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
            let students = try decoder.decode([Student].self, from: data)
                DispatchQueue.main.async {
                    self.students = students
                    self.loadState = .success
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
