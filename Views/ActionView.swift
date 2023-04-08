//
//  ActionView.swift
//  WWDC2023
//
//  Created by Kevin Dallian on 08/04/23.
//

import SwiftUI

struct ActionView: View {
    @StateObject var ivm : ItemViewModel
    @Binding var alertTitle : String
    @Binding var alertMessage : String
    @Binding var showAlert : Bool
    
    func makeAlert(title : String, message : String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    var body: some View {
        HStack{
            VStack{
                Button("Attack"){
                    ivm.action(choice: "attack", character1: ivm.characters[0], character2: ivm.characters[1])
                    if ivm.characters[1].hp <= 0 {
                        makeAlert(title: "You Win!", message: "You reduce your enemy's health to 0!")
                    }else if ivm.characters[0].hp <= 0{
                        makeAlert(title: "You Lose!", message: "Enemy reduce your health to 0!")
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        ivm.enemyAction()
                    }
                }
                .buttonStyle(.borderedProminent)
                Button("Defend"){
                    ivm.action(choice: "defend", character1: ivm.characters[0], character2: ivm.characters[1])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        ivm.enemyAction()
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                Button("Potion"){
                    ivm.action(choice: "potion", character1: ivm.characters[0], character2: ivm.characters[1])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        ivm.enemyAction()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            ScrollView{
                ForEach(ivm.logs, id: \.self){ log in
                    Text("[Turn \(log.turn)] : \(log.character) \(log.message)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }.frame(maxHeight: 200)
    }
}

