//
//  Potion.swift
//  WWDC2023
//
//  Created by Kevin Dallian on 06/04/23.
//

import Foundation

class Potion: Identifiable, ObservableObject{
    var name : String
    var desc : String
    var debuff : Double
    var affectedTurn : Int
    var turnUsed : Int = 0
    var price : Int
    
    init(name: String, desc: String, debuff: Double, affectedTurn: Int, price: Int) {
        self.name = name
        self.desc = desc
        self.debuff = debuff
        self.affectedTurn = affectedTurn
        self.price = price
    }
}
