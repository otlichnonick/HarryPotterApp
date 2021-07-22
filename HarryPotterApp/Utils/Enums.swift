//
//  Enums.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import Foundation

enum LoadState {
    case initial
    case load
    case success
    case fail
}

enum Houses: String, CaseIterable {
    case Gryffindor
    case Slytherin
    case Hufflepuff
    case Ravenclaw
}
