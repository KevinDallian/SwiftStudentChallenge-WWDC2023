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
                .font(.largeTitle)
            if ivm.characters[0].potions.isEmpty{
                Text("No potions in inventory")
            }else{
                ScrollView{
                    ForEach(ivm.characters[0].potions){potion in
                        HStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(maxWidth: 40, maxHeight: 40)
                                .foregroundColor(Color.gray)
                            VStack(alignment: .leading){
                                Text("\(potion.name)")
                                Text("\(potion.desc)")
                            }
                            Spacer()
                            Button("Use"){
                                ivm.action(choice: "potion", character1: ivm.characters[0], character2: ivm.characters[1], potionUsed: potion)
                                potionButton = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    ivm.enemyAction()
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.trailing, 10)
            }
        }
        
    }
}

