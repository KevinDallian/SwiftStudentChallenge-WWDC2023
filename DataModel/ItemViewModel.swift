//
//  ItemViewModel.swift
//  
//
//  Created by Kevin Dallian on 06/04/23.
//

import Foundation
import SwiftUI

class ItemViewModel : ObservableObject{
    @Published var logs : [Log] = []
    @Published var turn : Int = 1
    @Published var characters : [Character] = []
    
    func addLog(turn : Int, character : String, message : String){
        withAnimation {
            logs.insert(Log(turn: turn, character: character, message: message), at: 0)
        }
    }
    
    func addCharacter(name : String, hp : Int, baseAttack : Int, criticalChance : Int){
        characters.append(Character(name: name, hp: hp, baseAttack: baseAttack, criticalChance: criticalChance))
    }
    
    init(){
        addCharacter(name: "Blue Circle", hp: 100, baseAttack: 10, criticalChance: 20)
        addCharacter(name: "Red Circle", hp: 100, baseAttack: 10, criticalChance: 20)
    }
    
    func resetGame(){
        logs.removeAll()
        characters.removeAll()
        turn = 1
        addCharacter(name: "Blue Circle", hp: 100, baseAttack: 10, criticalChance: 20)
        addCharacter(name: "Red Circle", hp: 100, baseAttack: 10, criticalChance: 20)
    }
    
    func getCrit(critChance : Int) -> Bool{
        let chance = Int.random(in: 1...100)
        if chance <= critChance {
            return true
        }
        return false
    }
    
    func attack(character1 : Character, character2: Character){
        var attack = 0
        var message = ""
        if getCrit(critChance: character1.criticalChance){
            attack = character1.baseAttack * 2
            message = "attacks \(character2.name) with Critical hit"
        }else{
            attack = character1.baseAttack
            message = "attacks \(character2.name)"
        }
        if character2.isDefending{
            attack /= 2
            character2.isDefending = false
            message += " (Defended)."
        }else{
            message += "."
        }
        character2.hp -= attack
        message += " Damage : \(attack)"
        
        addLog(turn: turn, character: character1.name, message: message)
        turn += 1
    }
    
    func defend(character : Character){
        character.isDefending = true
        addLog(turn: turn, character: character.name, message: "switch stance to defend stance")
        turn += 1
    }
    
    func potion(){
        addLog(turn: turn, character: "Blue Circle", message: "Use Potion")
        turn += 1
    }
    
    func action(choice : String, character1: Character, character2: Character){
        switch choice{
            case "attack":
                attack(character1: character1, character2: character2)
            case "defend":
                defend(character: character1)
            case "potion":
                potion()
            default:
                print("Player doesn't choose action")
        }
    }
    
    func enemyAction(){
        var choice : Int
        if characters[1].isDefending == true{
            choice = Int.random(in: 1...2)
        }else{
            choice = Int.random(in: 1...3)
        }
        if choice == 1{ // attack
            action(choice: "attack", character1: characters[1], character2: characters[0])
        }else if choice == 2{ // potion
            action(choice: "potion", character1: characters[1], character2: characters[0])
        }else{ // defend
            action(choice: "defend", character1: characters[1], character2: characters[0])
        }
    }
}
