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
    @State var potionButton : Bool = false
    
    func makeAlert(title : String, message : String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    var body: some View {
        HStack{
            VStack{
                Button{
                    ivm.action(choice: "attack", character1: ivm.characters[0], character2: ivm.characters[1], potionUsed: nil)
                    if ivm.characters[1].hp <= 0 {
                        makeAlert(title: "You Win!", message: "You reduce your enemy's health to 0!")
                    }else if ivm.characters[0].hp <= 0{
                        makeAlert(title: "You Lose!", message: "Enemy reduce your health to 0!")
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        ivm.enemyAction()
                    }
                    potionButton = false
                } label:{
                    Text("Attack")
                        .font(.title)
                        .frame(width: 150.0, height: 60.0)
                }
                .frame(width: 200.0)
                .buttonStyle(.borderedProminent)
                Button{
                    ivm.action(choice: "defend", character1: ivm.characters[0], character2: ivm.characters[1], potionUsed: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        ivm.enemyAction()
                    }
                    potionButton = false
                }label:{
                    Text("Defend")
                        .font(.title)
                        .frame(width: 150.0, height: 60.0)
                }
                .buttonStyle(.borderedProminent)
                Button{
                    withAnimation(){
                        potionButton.toggle()
                    }
                }label:{
                    Text("Potion")
                        .font(.title)
                        .frame(width: 150.0, height: 60.0)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.leading, 10.0)
            .frame(minWidth: 250)
            ScrollView{
                if !potionButton{
                    HStack{
                        Text("Log History")
                            .font(.largeTitle)
                        Spacer()
                    }
                    if ivm.logs.isEmpty{
                        Text("This page here represents your and enemy history actions. Use this page to keep track with enemy's actions and plan ahead.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.trailing)
                    }
                    else{
                        ForEach(ivm.logs, id: \.self){ log in
                            Text("[Turn \(log.turn)] : \(log.character) \(log.message)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }else {
                    PotionView(ivm : ivm, potionButton: $potionButton)
                }
            }.padding(.trailing, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
        }.frame(maxHeight: 250)
    }
}

