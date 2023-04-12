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
        VStack {
            VStack{
                Text("\(ivm.whosTurn)!")
                    .font(.largeTitle.weight(.bold))
                Text("Turn \(ivm.turn)")
                    .font(.title)
                HStack {
                    VStack{
                        Text("\(ivm.characters[0].hp)")
                            .font(.title.weight(.semibold))
                        Circle()
                            .fill(.blue)
                    }
                    VStack{
                        Text("\(ivm.characters[1].hp)")
                            .font(.title.weight(.semibold))
                        Circle()
                            .fill(.red)
                    }
                }.padding()
            }
            Divider()
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
