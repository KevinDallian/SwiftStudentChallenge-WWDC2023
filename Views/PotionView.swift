//
//  PotionView.swift
//  
//
//  Created by Kevin Dallian on 08/04/23.
//

import SwiftUI

struct PotionView: View {
    @StateObject var ivm : ItemViewModel
    @Binding var potionButton : Bool
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Potion Inventory")
                .font(.largeTitle.weight(.semibold))
            if ivm.characters[0].potions.isEmpty{
                Text("No potions in inventory")
            }else{
                ScrollView{
                    ForEach(ivm.characters[0].potions){potion in
                        HStack{
                            Image(systemName: potion.name == "Healing Potion" ? "h.circle.fill" : "w.circle.fill")
                                .foregroundColor(potion.name == "Healing Potion" ? .red : .black)
                                .font(.system(size: 50))
                            VStack(alignment: .leading){
                                Text("\(potion.name)")
                                    .font(.title)
                                Text("\(potion.desc)")
                                    .font(.title.weight(.light))
                            }
                            Spacer()
                            Button{
                                ivm.action(choice: "potion", character1: ivm.characters[0], character2: ivm.characters[1], potionUsed: potion)
                                potionButton = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    ivm.enemyAction()
                                }
                            } label: {
                                Text("Use")
                                    .font(.title)
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                    }
                }
                .padding(.trailing, 10)
            }
        }
        
    }
}

