import SwiftUI

struct HomeView: View {
    // MARK: - ©Properties
    /*©-----------------------------------------©*/
    @State var messageToClear = ""
    @State var enteredMsg = ""
    @State var docId = ""
    @State var updateMsg = false
    @ObservedObject var homeViewModel = HomeViewModel()
    /*©-----------------------------------------©*/
    
    var body: some View {
        /**|----------|*/
        /**|          |*/
        ZStack {
            /**|          |*/
            VStack {
                /**|----------|*/
                List {
                    // Iterating through our messages
                    ForEach(self.homeViewModel.listOfMsgs) { message in
                        /**|          |*/
                        Text(message.msg)
                            
                            .onTapGesture {
                                self.docId = message.id!
                                
                                withAnimation {
                                    self.updateMsg.toggle()
                                }
                        }
                    }
                    .onDelete { indexSet in
                        /**|----------|*/
                        for index in indexSet {
                            self.homeViewModel.deleteMsg(docIdIndex: index)
                        }
                    }
                }
                
                HStack(spacing: 15) {
                    TextField("Message", text: $enteredMsg)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        let newMsg = Message(msg: self.enteredMsg, date: .init(date: Date()))
                        /**|     ⇪     |*/
                        self.homeViewModel.createMsg(msg: newMsg) { (result) in
                            switch result {
                                case .success(_):
                                    return printf("Message created..\n\(result)")
                                case .failure(let error): printf(error)
                            }
                        }
                        // Clearing message
                        self.clearTextField()
                    }) {
                        Text("Add").fontWeight(.bold)
                    }
                }
                .padding()
            }// END OF VSTACK
            
            if self.updateMsg {
                UpdateView(homeModelView: self.homeViewModel,
                           dismiss: $updateMsg, docId: $docId)
            }
        }
        .navigationBarTitle("Home")
            // Adds a edit button on the nav bar trailing -->
            .navigationBarItems(trailing: EditButton())
            .onAppear {
                // You can also call this in init(){}
                self.homeViewModel.fetchAllMsgs()
        }
    }
    
    // MARK: - Helper method
    fileprivate func clearTextField() {
        self.enteredMsg = self.messageToClear
        self.messageToClear = ""
       }
    
}// END OF STRUCT

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.fixed(width: 420, height: 520))
        
    }
}
