//
//  Character.swift
//  WWDC2023
//
//  Created by Kevin Dallian on 06/04/23.
//

import Foundation

class Character : Identifiable, ObservableObject {
    var id = UUID().uuidString
    var name : String
    var hp : Int
    var baseAttack : Double
    var criticalChance : Double
    
    init(name: String, hp: Int, baseAttack: Double, criticalChance: Double) {
        self.name = name
        self.hp = hp
        self.baseAttack = baseAttack
        self.criticalChance = criticalChance
    }
}
