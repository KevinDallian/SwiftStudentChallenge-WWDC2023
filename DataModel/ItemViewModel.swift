//
//  ItemViewModel.swift
//  
//
//  Created by Kevin Dallian on 06/04/23.
//

import Foundation
import AVFoundation
import SwiftUI

class ItemViewModel : ObservableObject{
    @Published var logs : [Log] = []
    @Published var turn : Int = 1
    @Published var characters : [Character] = []
    @Published var whosTurn : String = "Your Turn"
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    var music : AVAudioPlayer!
    
    init(){
        addCharacter(name: "Blue Knight", hp: 100, baseAttack: 10, criticalChance: 20)
        addCharacter(name: "Red Knight", hp: 100, baseAttack: 10, criticalChance: 20)
        for _ in 1 ... 3{
            addPotion(character: characters[0], potion: createPotion(index: Int.random(in: 1..<3)))
            addPotion(character: characters[1], potion: createPotion(index: Int.random(in: 1..<3)))
        }
    }
    
    func makeAlert(title : String, message : String){
        alertTitle = title
        alertMessage = message
        showAlert = true
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
        var potion : Potion = Potion(name: "Healing Potion", desc: "Heals the user for 20 hp.", type: "Heal", debuff: 20, affectedTurn: 0)
        switch index{
        case 1:
            potion = Potion(name: "Healing Potion", desc: "Heals the user for 20 hp.", type: "Heal", debuff: 20, affectedTurn: 0)
        case 2:
            potion = Potion(name: "Weakness Potion", desc: "Reduce enemy's attack to 5", type: "Attack Debuff", debuff: 5, affectedTurn: 3)
        default:
            print("Index must be 1 or 2")
        }
        return potion
    }
    
    func addPotion(character: Character, potion: Potion){
        character.potions.append(potion)
    }
    
    func resetGame(){
        logs.removeAll()
        characters.removeAll()
        turn = 1
        addCharacter(name: "Blue Circle", hp: 100, baseAttack: 10, criticalChance: 20)
        addCharacter(name: "Red Circle", hp: 100, baseAttack: 10, criticalChance: 20)
        for _ in 1 ... 3{
            addPotion(character: characters[0], potion: createPotion(index: Int.random(in: 1..<3)))
            addPotion(character: characters[1], potion: createPotion(index: Int.random(in: 1..<3)))
        }
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
        let message = "uses \(potion.name) that \(potion.desc.lowercased())"
        if potion.type == "Heal"{
            if character1.hp + 20 >= 100{
                character1.hp = 100
            }else{
                character1.hp += 20
            }
        }else if potion.type == "Attack Debuff"{
            character2.baseAttack -= potion.debuff
        }
        if let index = character1.potions.firstIndex(of: potion){
            potion.turnUsed = turn
            if potion.name == "Weakness Potion"{
                character2.debuffs.append(potion)
            }
            character1.potions.remove(at: index)
        }
        addLog(turn: turn, character: character1.name, message: message)
    }
    
    func action(choice : String, character1: Character, character2: Character, potionUsed : Potion?){
        if character1.isDefending {
            character1.isDefending = false
        }
        switch choice{
            case "attack":
                attack(character1: character1, character2: character2)
            case "defend":
                defend(character: character1)
            case "potion":
            potion(character1 : character1, character2: character2, potion : potionUsed ?? Potion(name: "No Potion", desc: "User does not use potion", type: "Nil", debuff: 0, affectedTurn: 0))
            default:
                print("Player doesn't choose action")
        }
        withAnimation{
            endTurn()
            if characters[1].hp <= 0 {
                makeAlert(title: "You Win!", message: "You reduce your enemy's health to 0!")
            }else if characters[0].hp <= 0{
                makeAlert(title: "You Lose!", message: "Enemy reduce your health to 0!")
            }
        }
    }
    
    func enemyAction(){
        var choice = 0
        if characters[1].isDefending{
            characters[1].isDefending = false
        }
        if characters[1].potions.isEmpty{
            choice = Int.random(in: 1...2)
        }else{
            choice = Int.random(in: 1...3)
        }
        
        if choice == 1 { // attack
            action(choice: "attack", character1: characters[1], character2: characters[0], potionUsed: nil)
        }else if choice == 2{ // defend
            action(choice: "defend", character1: characters[1], character2: characters[0], potionUsed: nil)
        }else{ // potion
            action(choice: "potion", character1: characters[1], character2: characters[0], potionUsed: characters[1].potions.first)
        }
    }
    
    func checkDebuffExpire(character : Character)-> Bool{
        if let potion = character.debuffs.first{
            if turn - potion.turnUsed >= potion.affectedTurn {
                return true
            }
        }
        return false
    }
    
    func endTurn(){
        if whosTurn == "Your Turn"{
            whosTurn = "Enemy's Turn"
        }else{
            whosTurn = "Your Turn"
            turn += 1
            if checkDebuffExpire(character: characters[0]){
                characters[0].baseAttack += 5
                characters[0].debuffs.removeFirst()
                addLog(turn: turn, character: characters[0].name, message: "'s weakness has been repelled")
            }
            if checkDebuffExpire(character: characters[1]){
                characters[1].baseAttack += 5
                characters[1].debuffs.removeFirst()
                addLog(turn: turn, character: characters[1].name, message: "'s weakness has been repelled")
            }
        }
    }
}
