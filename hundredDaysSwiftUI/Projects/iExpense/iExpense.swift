// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct iExpense: View {
    @StateObject private var user = User()
    @State private var showingSheet = false

    var body: some View {
        VStack {
            Spacer()

            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)

            Spacer()

            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(user: user)
            }

            Spacer()
        }
    }
}

struct SecondView: View {
    @ObservedObject var user: User

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("Hello, \(user.firstName)!")

        Button("Dismiss") {
            dismiss()
        }
    }
}

struct iExpense_Previews: PreviewProvider {
    static var previews: some View {
        iExpense()
    }
}
