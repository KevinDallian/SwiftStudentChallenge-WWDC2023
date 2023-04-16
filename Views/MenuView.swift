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
                Image("background")
                VStack{
                    Image("logo_white")
                        .resizable()
                        .frame(width: 500, height: 500)
                    NavigationLink{
                        ContentView()
                    }label: {
                        Text("Start Game")
                            .font(.title.weight(.semibold))
                            .frame(width: 175, height: 50)
                    }
                    .buttonStyle(.borderedProminent)
                    NavigationLink{
                        TutorialView()
                    }label: {
                        Text("How to Play")
                            .font(.title.weight(.semibold))
                            .frame(width: 175, height: 50)
                    }
                    .buttonStyle(.borderedProminent)
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
