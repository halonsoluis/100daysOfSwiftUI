// Created for hundredDaysSwiftUI.WeSplit in 2023
// Using Swift 5.0

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    private var tipPercentages = [0, 5, 10, 15, 18, 20]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Total Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)


                    Picker("Amount of People", selection: $numberOfPeople) {
                        ForEach(2..<100) { amount in
                            Text("\(amount) people")
                        }
                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))

                } header: {
                    Text("Each one will pay")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }

    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipPercentage = Double(tipPercentage) / 100
        let tip = amount * tipPercentage

        return (amount + tip) / peopleCount
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
