//
//  TutorialView.swift
//  WWDC2023
//
//  Created by Kevin Dallian on 16/04/23.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
        ZStack{
            Image("background")
            VStack{
                ZStack{
                    ScrollView{
                        Section{
                            Text("How to Play")
                                .font(.largeTitle.weight(.bold))
                            Text("Knight’s Honor is a turn-based game where characters take turns to do action. You are the blue knight standing on the left side of the screen. The goal of the game is to reduce enemy’s(red knight) health point to 0. Both characters have base health of 100. To achieve the goal you can choose 3 actions provided.")
                                .font(.title)
                        }
                        Section{
                            HStack{
                                Button {
                                } label: {
                                    Text("Attack")
                                        .font(.title.weight(.bold))
                                        .frame(width: 200, height: 60)
                                }.buttonStyle(.borderedProminent)
                                Spacer()
                            }
                            Text("Attack button is used for attacking the enemy with a base attack of 10 HP. There are 20% chances of the attack to be critical that doubles the amount of base attack (20 HP).")
                                .font(.title)
                        }
                        Section{
                            HStack{
                                Button {
                                } label: {
                                    Text("Defend")
                                        .font(.title.weight(.bold))
                                        .frame(width: 200, height: 60)
                                }.buttonStyle(.borderedProminent)
                                Spacer()
                            }
                            Text("""
            Defend button lets your character(blue knight) switch stance to defense.  With defense stance, if the enemy attacks you the base attack will be reduced half from the total attack.

            For example, your character is in defense stance and the enemy hits you with critical hit(20 HP), your character HP will be reduce by 10 HP because of the defense stance.

            Defense stance will be reset in end of turn.
            """)
                                .font(.title)
                        }
                        Section{
                            HStack{
                                Button {
                                } label: {
                                    Text("Potion")
                                        .font(.title.weight(.bold))
                                        .frame(width: 200, height: 60)
                                }.buttonStyle(.borderedProminent)
                                Spacer()
                            }
                            Text("""
            Potion button lets your character(blue knight) to use potions that is listed in your character’s inventory. Every time you start the game, your character will have 3 random potions. List of the potions available are provided below:
            1.  Healing Potion : Heals your character for 20 HP. Healing potion can't overheal, for example your character has 90 and uses healing potion, your character's health will be 100.
            2. Weakness Potion : Reduce enemy’s base attack by half in 3 turns. Whenever the weakness potion expires, enemy’s base attack will be revert to normal.
            """)
                                .font(.title)
                        }
                    }
                    .padding(30)
                    .background(.regularMaterial)
                    .cornerRadius(10)
                    
                }
            }
            .padding(40.0)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
