import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable, Codable {
    // MARK: - ©Properties
    /*©-----------------------------------------©*/
    @DocumentID var id: String?
    var msg: String
    var date: Timestamp
    /*©-----------------------------------------©*/
    
    // MARK: -#Keys
    enum CodingKeys: String, CodingKey {
        case id
        case msg = "Message"
        case date
    }
}


