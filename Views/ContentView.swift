import SwiftUI

struct ContentView: View {
    @StateObject var ivm = ItemViewModel()
    
    @Environment(\.presentationMode) var presentationMode

    
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
                                    .frame(width: Double(ivm.characters[0].hp) * 1.75, height: 25)
                                    .border(.black)
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: Double(100 - ivm.characters[0].hp) * 1.75, height: 25)
                                    .border(.black)
                            }.offset(x: -30)
                            Image("knight_blue")
                                .resizable()
                        }
                        VStack{
                            HStack(alignment: .bottom, spacing: 0){
                                Rectangle()
                                    .fill(.green)
                                    .frame(width: Double(ivm.characters[1].hp) * 1.75, height: 25)
                                    .border(.black)
                                Rectangle()
                                    .fill(.red)
                                    .frame(width: Double(100 - ivm.characters[1].hp) * 1.75, height: 25)
                                    .border(.black)
                            }.offset(x: 30)
                            Image("knight_red")
                                .resizable()
                        }
                    }.padding()
                }
                ActionView(ivm : ivm)
                
            }.alert(ivm.alertTitle, isPresented: $ivm.showAlert) {
                Button("Back to menu"){
                    self.presentationMode.wrappedValue.dismiss()
                }
            } message: {
                Text(ivm.alertMessage)
            }
        }
    }
}
