// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct ListActions: View {
    @State private var numbers = [Int]()
    @AppStorage("ListActions.Number") private var currentNumber = 0

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
                }
            }
            .navigationTitle("onDelete()")
            .toolbar { // Always make sure this is not on the NavigationView, weird behaviour may happen
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
