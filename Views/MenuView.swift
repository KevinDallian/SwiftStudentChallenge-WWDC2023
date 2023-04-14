//
//  MenuView.swift
//  
//
//  Created by Kevin Dallian on 14/04/23.
//

import SwiftUI

struct MenuView: View {
    @State private var animationAmount = 1.0
    var body: some View {
        NavigationView{
            VStack{
                Text("Game Title")
                    .font(.largeTitle.weight(.bold))
                    .scaleEffect(animationAmount)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animationAmount)
                    .onAppear{
                        animationAmount = 1.25
                    }
                NavigationLink{
                    ContentView()
                }label: {
                    Text("Start Game")
                        .font(.title)
                }
                .buttonStyle(.borderedProminent)
            }
        }.navigationViewStyle(.stack)
        
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
