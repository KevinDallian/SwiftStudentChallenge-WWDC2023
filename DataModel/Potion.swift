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
    var turn : Int
    var price : Int
    
    init(name: String, desc: String, debuff: Double, turn: Int, price: Int) {
        self.name = name
        self.desc = desc
        self.debuff = debuff
        self.turn = turn
        self.price = price
    }
}
