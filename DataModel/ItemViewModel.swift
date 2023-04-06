//
//  ItemViewModel.swift
//  
//
//  Created by Kevin Dallian on 06/04/23.
//

import Foundation

class ItemViewModel : ObservableObject{
    @Published var logs : [Log] = []
    @Published var turn : Int = 1
    @Published var characters : [Character] = []
    
    func addLog(turn : Int, character : String, message : String){
        logs.append(Log(turn: turn, character: character, message: message))
    }
    
    func addCharacter(name : String, hp : Int, baseAttack : Double, criticalChance : Double){
        characters.append(Character(name: name, hp: hp, baseAttack: baseAttack, criticalChance: criticalChance))
    }
    
    func attack(){
        
    }
    
    func defend(){
        
    }
    
    func potion(potion : Potion){
        
    }
}
