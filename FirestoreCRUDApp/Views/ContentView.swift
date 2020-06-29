import SwiftUI

struct ContentView: View {
    // MARK: - @Properties
    
    
    var body: some View {
        /**|----------|*/
        NavigationView {
            HomeView()
        }.preferredColorScheme(.dark)
    }
}

// MARK: - ©Preview
/*©-----------------------------------------©*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .previewLayout(.fixed(width: 420, height: 520))
    }
}
/*©-----------------------------------------©*/
