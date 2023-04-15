//
//  Potion.swift
//  WWDC2023
//
//  Created by Kevin Dallian on 06/04/23.
//

import Foundation
import SwiftUI

class Potion: ObservableObject, Hashable, Identifiable{
    static func == (lhs: Potion, rhs: Potion) -> Bool {
        return lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    var id = UUID().uuidString
    var name : String
    var desc : String
    var type : String
    var debuff : Int
    var affectedTurn : Int
    var turnUsed : Int = 0
    
    init(name: String, desc: String, type: String, debuff: Int, affectedTurn: Int) {
        self.name = name
        self.desc = desc
        self.type = type
        self.debuff = debuff
        self.affectedTurn = affectedTurn
    }
}
