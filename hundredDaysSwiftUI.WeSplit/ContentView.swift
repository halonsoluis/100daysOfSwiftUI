// Created for hundredDaysSwiftUI.WeSplit in 2023
// Using Swift 5.0

import SwiftUI

struct ContentView: View {
    @State private var amount: Float = 0.0
    @State private var numberOfPeople: Int = 2

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Total Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        .keyboardType(.decimalPad)


                    Picker("Amount of People", selection: $numberOfPeople) {
                        ForEach(2..<100) { amount in
                            Text("\(amount) people")
                        }
                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                Section {
                    Text("The split amount is \(amount / Float(numberOfPeople + 2))")
                }
            }.navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
