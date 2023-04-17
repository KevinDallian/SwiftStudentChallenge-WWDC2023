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
        ZStack{
            RoundedRectangle(cornerRadius: 50)
                .fill(.white)
            VStack{
                ScrollView{
                    if !potionButton{
                        HStack{
                            Text("Log History")
                                .font(.title.weight(.semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        if ivm.logs.isEmpty{
                            Text("This page here represents your and enemy history actions. Use this page to keep track with enemy's actions and plan ahead.")
                                .font(.title)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.black)
                                .padding(.trailing)
                        }
                        else{
                            ForEach(ivm.logs, id: \.self){ log in
                                Text("[Turn \(log.turn)] : \(log.character) \(log.message)")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }else {
                        PotionView(ivm : ivm, potionButton: $potionButton)
                    }
                }.padding()
                HStack{
                    Spacer()
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
                            .font(.title.weight(.bold))
                            .padding(.horizontal, 10)
                    }
                    .disabled(ivm.whosTurn == "Enemy's Turn")
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(70)
                    .shadow(color: Color(red: 0, green: 185/225, blue: 1).opacity(0.53), radius: 0, x: 3, y: 5)
                    Spacer()
                    Button{
                        ivm.action(choice: "defend", character1: ivm.characters[0], character2: ivm.characters[1], potionUsed: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            ivm.enemyAction()
                        }
                        potionButton = false
                    }label:{
                        Text("Defend")
                            .font(.title.weight(.bold))
                            .padding(.horizontal, 10)
                    }
                    .disabled(ivm.whosTurn == "Enemy's Turn")
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(70)
                    .shadow(color: Color(red: 0, green: 185/225, blue: 1).opacity(0.53), radius: 0, x: 3, y: 5)
                    Spacer()
                    Button{
                        withAnimation(){
                            potionButton.toggle()
                        }
                    }label:{
                        Text("Potion")
                            .font(.title.weight(.bold))
                            .padding(.horizontal, 10)
                    }
                    .disabled(ivm.whosTurn == "Enemy's Turn")
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(70)
                    .shadow(color: Color(red: 0, green: 185/225, blue: 1).opacity(0.53), radius: 0, x: 3, y: 5)
                    Spacer()
                }.padding(.bottom, 100)
            }
        }
    }
}


