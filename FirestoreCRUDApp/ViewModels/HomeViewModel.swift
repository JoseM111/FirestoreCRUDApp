import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import Firebase


class HomeViewModel: ObservableObject {
    // MARK: - ©Properties
    /*©-----------------------------------------©*/
    @Published var listOfMsgs: [Message] = []
    
    /*©-----------------------------------------©*/
    
    // MARK: _@CRUD
    /**©------------------------------------------------------------------------------©*/
    
    // MARK: - CREATE Add method signatures
    func createMsg(msg: Message, completion: @escaping Bool_or_Error) {
        // Firestore
        do {
            let _ = try refDB.collection(K.MessagesKey)
                .addDocument(from: msg) { error in
                // - Handling error
                    if let error = error {
                        printf("[ERROR] Could not create message..\n\(error.localizedDescription)")
                        return completion(.failure(error))
                    }
                    
                    // If successful
                    completion(.success(true))
            }
        } catch {
            printf(error.localizedDescription)
            completion(.failure(false as! Error))
        }
    }
    
    /// READ() if we have data to read
    func fetchAllMsgs() {
        
        refDB.collection(K.MessagesKey).order(by: "date", descending: false)
            /**|          |*/
            .addSnapshotListener { (snapShot, error) in
            // - Handling error
            if let error = error {
                return printf("..\n\(error.localizedDescription)")
            }
            
            guard let snapShot = snapShot else { return }
            
            snapShot.documentChanges.forEach { (doc) in
                /**|          |*/
                guard let msg = try? doc.document.data(as: Message.self)
                    else { return }
                
                if doc.type == .added {
                    self.listOfMsgs.append(msg)
                    /**|          |*/
                } else if doc.type == .modified {
                    
                    for i in 0 ..< self.listOfMsgs.count {
                        
                        if self.listOfMsgs[i].id == msg.id! {
                            self.listOfMsgs[i] = msg
                        }
                    }
                }
                
                printf("Created: \(msg.date.dateValue().dateRightNow())")
            }
        }
    }
    
    // MARK: - UPDATE Add method signatures
    func updateMsg(msg: String, docId: String, completion: @escaping Bool_or_Error) {
        /**|          |*/
        refDB.collection(K.MessagesKey).document(docId).updateData([ K.MsgKey : msg ]) { error in
            //Handling error
            if let error = error {
                printf("Could not update message..\n\(error.localizedDescription)")
                return completion(.failure(false as! Error))
            }
            
            printf("Successfully updated message...")
            completion(.success(true))
        }
    }
    
    // MARK: - DELETE Add method signatures
    func deleteMsg(docIdIndex: Int) {
        /**|          |*/
        refDB.collection(K.MessagesKey).document(listOfMsgs[docIdIndex].id!).delete { error in
            // - Handling error
            if let error = error {
                return printf("[ERROR] Could not delete message..\n\(error.localizedDescription)")
            }
            
            self.listOfMsgs.remove(at: docIdIndex)
            printf("Message deleted...")
        }
    }
    
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS
