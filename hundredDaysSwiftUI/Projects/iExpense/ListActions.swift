// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct ListActions: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = UserDefaults.standard.integer(forKey: "ListActions.Number")

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) { //Needed to have the onDelete modifier
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                    UserDefaults.standard.set(self.currentNumber, forKey: "ListActions.Number")
                }
            }
            .navigationTitle("onDelete()")
            .toolbar {
                EditButton()
            }
        }

    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ListActions_Previews: PreviewProvider {
    static var previews: some View {
        ListActions()
    }
}
