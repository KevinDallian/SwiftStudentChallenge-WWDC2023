import SwiftUI

struct ContentView: View {
    @StateObject var ivm = ItemViewModel()
    @State var selectedButton = "action"
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
            if selectedButton == "action"{
                ActionView(ivm : ivm, alertTitle: $alertTitle, alertMessage: $alertMessage, showAlert: $showAlert)
            }
        }.alert(alertTitle, isPresented: $showAlert) {
            Button("Back to menu"){
                ivm.resetGame()
            }
        } message: {
            Text(alertMessage)
        }
    }
}
