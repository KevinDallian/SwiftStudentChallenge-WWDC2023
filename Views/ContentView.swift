import SwiftUI

struct ContentView: View {
    @StateObject var itemViewModel = ItemViewModel()
    @State private var turn : Int = 1
    
    var body: some View {
        VStack {
            VStack{
                Text("Turn")
                    .font(.largeTitle.weight(.bold))
                Text("\(turn)")
                    .font(.title)
                HStack {
                    Circle()
                        .fill(.blue)
                    Circle()
                        .fill(.red)
                }
            }
                   
            HStack{
                VStack{
                    Button("Attack"){
                        itemViewModel.attack()
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Defend"){
                        itemViewModel.defend()
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Potion"){
                        itemViewModel.potion(potion: Potion(name: "", desc: "", debuff: 0, turn: 1, price: 1))
                    }
                    .buttonStyle(.borderedProminent)
                }
                ScrollView{
                    ForEach(itemViewModel.logs, id: \.self){ log in
                        Text("[\(log.turn)] : \(log.character) \(log.message)")
                    }
                }
                
            }.frame(maxHeight: 200)
        }
    }
}
