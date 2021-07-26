//
//  Enums.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import Foundation

enum LoadState {
    case loading
    case success
    case failure
}

enum Houses: String, CaseIterable {
    case Gryffindor
    case Slytherin
    case Hufflepuff
    case Ravenclaw
}
