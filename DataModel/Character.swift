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
    var baseAttack : Int
    var criticalChance : Int
    var isDefending : Bool
    var potion : [Potion] = []
    
    init(name: String, hp: Int, baseAttack: Int, criticalChance: Int) {
        self.name = name
        self.hp = hp
        self.baseAttack = baseAttack
        self.criticalChance = criticalChance
        self.isDefending = false
    }
}
