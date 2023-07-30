// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct iExpense: View {
    @StateObject private var user = User()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct iExpense_Previews: PreviewProvider {
    static var previews: some View {
        iExpense()
    }
}
