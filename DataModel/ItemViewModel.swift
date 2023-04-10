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
    @Published var whosTurn : String = "Your Turn"
    
    init(){
        addCharacter(name: "Blue Circle", hp: 100, baseAttack: 10, criticalChance: 20)
        addCharacter(name: "Red Circle", hp: 100, baseAttack: 10, criticalChance: 20)
    }
    
    func addLog(turn : Int, character : String, message : String){
        withAnimation {
            logs.insert(Log(turn: turn, character: character, message: message), at: 0)
        }
    }
    
    func addCharacter(name : String, hp : Int, baseAttack : Int, criticalChance : Int){
        characters.append(Character(name: name, hp: hp, baseAttack: baseAttack, criticalChance: criticalChance))
    }
    
    func createPotion(index : Int) -> Potion {
        var potion : Potion = Potion(name: "Healing Potion", desc: "Heals the user for 20 hp.", type: "Heal", debuff: 20, affectedTurn: 0, price: 50)
        switch index{
        case 1:
            potion = Potion(name: "Healing Potion", desc: "Heals the user for 20 hp.", type: "Heal", debuff: 20, affectedTurn: 3, price: 50)
        case 2:
            potion = Potion(name: "Weakness Potion", desc: "Reduce enemy's attack to 5", type: "Attack Debuff", debuff: 2, affectedTurn: 3, price: 50)
        default:
            print("Index must be 1 or 2")
        }
        return potion
    }
    
    func addPotion(character: Character, potion: Potion){
        character.potion.append(potion)
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
    }
    
    func defend(character : Character){
        character.isDefending = true
        addLog(turn: turn, character: character.name, message: "switch stance to defend stance")
    }
    
    func potion(character1 : Character, character2 : Character, potion : Potion){
        var message = "uses \(potion.name) that \(potion.desc.lowercased())"
        if potion.type == "Heal"{
            character1.hp += 20
        }else if potion.type == "Attack Debuff"{
            character2.baseAttack -= potion.debuff
        }
        addLog(turn: turn, character: character1.name, message: message)
    }
    
    func action(choice : String, character1: Character, character2: Character){
        if character1.isDefending {
            character1.isDefending = false
        }
        switch choice{
            case "attack":
                attack(character1: character1, character2: character2)
            case "defend":
                defend(character: character1)
            case "potion":
            potion(character1 : character1, character2: character2, potion : Potion(name: "", desc: "", type: "", debuff: 2, affectedTurn: 3, price: 0))
            default:
                print("Player doesn't choose action")
        }
        withAnimation{
            whosTurn = "Enemy's Turn"
        }
    }
    
    func enemyAction(){
        if characters[1].isDefending{
            characters[1].isDefending = false
        }
        let choice = Int.random(in: 1...3)
        if choice == 1 { // attack
            action(choice: "attack", character1: characters[1], character2: characters[0])
        }else if choice == 2{ // potion
            action(choice: "potion", character1: characters[1], character2: characters[0])
        }else{ // defend
            action(choice: "defend", character1: characters[1], character2: characters[0])
        }
        withAnimation{
            turn += 1
            whosTurn = "Your Turn"
        }
    }
}
