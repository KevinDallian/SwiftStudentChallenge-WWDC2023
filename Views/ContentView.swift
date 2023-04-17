import SwiftUI

struct ContentView: View {
    @StateObject var ivm = ItemViewModel()
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    func makeAlert(title : String, message : String){
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack {
                VStack{
                    Spacer()
                    Text("\(ivm.whosTurn)!")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.black)
                    Text("Turn \(ivm.turn)")
                        .font(.title)
                        .foregroundColor(.black)
                    Spacer()
                    HStack {
                        VStack{
                            HStack(alignment: .bottom, spacing: 0){
                                Rectangle()
                                    .fill(.green)
                                    .frame(width: Double(ivm.characters[0].hp) * 1.5, height: 25)
                                    .border(.black)
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: Double(100 - ivm.characters[0].hp) * 1.5, height: 25)
                                    .border(.black)
                            }
                            Image("knight_blue")
                                .resizable()
                        }
                        VStack{
                            HStack(alignment: .bottom, spacing: 0){
                                Rectangle()
                                    .fill(.green)
                                    .frame(width: Double(ivm.characters[1].hp) * 1.5, height: 25)
                                    .border(.black)
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: Double(100 - ivm.characters[1].hp) * 1.5, height: 25)
                                    .border(.black)
                            }.offset()
                            Image("knight_red")
                                .resizable()
                        }
                    }.padding()
                }
                ActionView(ivm : ivm, alertTitle: $alertTitle, alertMessage: $alertMessage, showAlert: $showAlert)
            }.alert(alertTitle, isPresented: $showAlert) {
                Button("Back to menu"){
                    self.presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
}
