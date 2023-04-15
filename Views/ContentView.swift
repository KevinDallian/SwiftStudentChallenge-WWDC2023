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
    
    var body: some View {
        ZStack{
            Image("background")
                .offset(y: -32)
            VStack {
                VStack{
                    Spacer()
                    Text("\(ivm.whosTurn)!")
                        .font(.largeTitle.weight(.bold))
                    Text("Turn \(ivm.turn)")
                        .font(.title)
                    Spacer()
                    HStack {
                        VStack{
                            Text("\(ivm.characters[0].hp)")
                                .font(.title.weight(.semibold))
                            Image("knight_blue")
                                .resizable()
                                .frame(width: 400, height: 400)
                        }
                        VStack{
                            Text("\(ivm.characters[1].hp)")
                                .font(.title.weight(.semibold))
                            Image("knight_red")
                                .resizable()
                                .frame(width: 400, height: 400)
                        }
                    }.padding()
                }
                .frame(minHeight: 800)
                ActionView(ivm : ivm, alertTitle: $alertTitle, alertMessage: $alertMessage, showAlert: $showAlert)
            }.alert(alertTitle, isPresented: $showAlert) {
                Button("Back to menu"){
                    ivm.resetGame()
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
}
