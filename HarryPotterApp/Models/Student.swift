//
//  Student.swift
//  HarryPotterApp
//
//  Created by Anton on 21.07.2021.
//

import Foundation
import BetterCodable

struct Student: Codable {
    var name : String = ""
    var species : String = ""
    var gender : String = ""
    var house : String = ""
    var dateOfBirth : String = ""
    @LosslessValue var yearOfBirth : String = ""
    var ancestry : String = ""
    var eyeColour : String = ""
    var hairColour : String = ""
    var wand : Wand = Wand()
    var patronus : String = ""
    var hogwartsStudent : Bool = false
    var hogwartsStaff : Bool = false
    var actor : String = ""
    var alive : Bool = false
    var image : String = ""
}

struct Wand: Codable {
    var wood : String = ""
    var core : String = ""
    @LosslessValue var length: String = ""
}
