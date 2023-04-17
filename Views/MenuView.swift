//
//  MenuView.swift
//  
//
//  Created by Kevin Dallian on 14/04/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("menubackground")
                    .resizable()
                    .ignoresSafeArea()
                VStack{
                    Image("logo_white")
                        .resizable()
                        .frame(width: 450, height: 450)
                        .offset(y: -50)
                    Spacer()
                    NavigationLink{
                        ContentView()
                    }label: {
                        Text("Start Game")
                            .font(.largeTitle.weight(.semibold))
                            .frame(width: 200, height: 60)
                    }
                    .buttonStyle(.borderedProminent)
                    NavigationLink{
                        TutorialView()
                    }label: {
                        Text("How to Play")
                            .font(.largeTitle.weight(.semibold))
                            .frame(width: 200, height: 60)
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
        }.navigationViewStyle(.stack)
            .onAppear(perform: {
                MusicPlayer.sharedMusic.playMusic()
            })
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
