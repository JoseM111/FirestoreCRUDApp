import SwiftUI

struct UpdateView: View {
    // MARK: - ©Properties
    /*©-----------------------------------------©*/
    @ObservedObject var homeModelView: HomeViewModel
    @Binding var dismiss: Bool
    @Binding var docId: String
    @State var msg = ""
    /*©-----------------------------------------©*/
    
    var body: some View {
        /**|          |*/
        VStack(alignment: .leading, spacing: 25) {
            Text("Message")
                .font(.title)
                .fontWeight(.bold)
            
            TextField("Message", text: $msg)
            .cornerRadius(10)
//            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack(spacing: 15) {
                /**|----- Update Button -----|*/
                Button(action: {
                    // Updating the message
                    self.homeModelView.updateMsg(
                    msg: self.msg, docId: self.docId) { result in
                        /**|          |*/
                        switch result {
                            case .success(_):
                                return printf("Updated message successfully!..\n\(result)")
                            case .failure(let error):
                                return printf("Unable to update message..\n\(error)")
                        }
                    };self.dismiss.toggle()
                /**|----- Cancel Button -----|*/
                }) { Text("Update").fontWeight(.bold) }
                
                Button(action: { withAnimation
                    { self.dismiss.toggle() }
                }) { Text("Cancel")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                }
                
                
            }
        }
        .padding().background(Color.black).cornerRadius(15)
        .padding(.horizontal, 25).background(Color.white.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
    }
}

