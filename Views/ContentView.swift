import SwiftUI

struct ContentView: View {
    @StateObject var ivm = ItemViewModel()
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert = false
    
    func makeAlert(title : String, message : String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    enum Action {
        case attack
        case defend
        case potion
    }
    
    var body: some View {
        VStack {
            VStack{
                Text("Turn")
                    .font(.largeTitle.weight(.bold))
                Text("\(ivm.turn)")
                    .font(.title)
                HStack {
                    VStack{
                        Text("\(ivm.characters[0].hp)")
                        Circle()
                            .fill(.blue)
                    }
                   
                    VStack{
                        Text("\(ivm.characters[1].hp)")
                        Circle()
                            .fill(.red)
                    }
                }.padding()
            }
                   
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
                        ivm.enemyAction()
                        
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Potion"){
                        ivm.action(choice: "potion", character1: ivm.characters[0], character2: ivm.characters[1])
                        ivm.enemyAction()
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
        }.alert(alertTitle, isPresented: $showAlert) {
            Button("Back to menu"){
                ivm.resetGame()
            }
        } message: {
            Text(alertMessage)
        }
    }
}
