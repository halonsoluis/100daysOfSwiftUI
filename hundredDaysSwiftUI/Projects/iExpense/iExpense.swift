// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem]

    init(items: [ExpenseItem]) {
        self.items = items
    }
}

struct iExpense: View {
    @StateObject private var expenses = Expenses(items: [
        ExpenseItem(name: "example", type: "private", amount: 100),
        ExpenseItem(name: "example 2", type: "private", amount: 1000),
        ExpenseItem(name: "example 3", type: "public", amount: 8),
    ])
    @State private var showingSheet = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.name)
                                    .font(.headline)
                                    .textCase(.uppercase)
                                Text(expense.type)
                                    .font(.subheadline)
                            }
                            Spacer()

                            Text(expense.amount,
                                 format: .currency(
                                    code: Locale.current.currency?.identifier ?? "EUR"
                                 )
                            )
                            .font(.callout)
                            .styled(amount: expense.amount)
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingSheet) {
                    SecondView(expenses: expenses)
                }
            }
            .navigationTitle("iExpense")
        }
    }
}

struct StyledAmount: ViewModifier {
    let under10 = Color.red
    let under100 = Color.blue
    let over100 = Color.green

    let amount: Int

    var style: Color {
        guard amount > 10 else {
            return under10
        }
        guard amount > 100 else {
            return under100
        }
        return over100
    }

    func body(content: Content) -> some View {
        content
            .foregroundColor(style)
    }
}

extension Text {
    func styled(amount: Int) -> some View {
        modifier(StyledAmount(amount: amount))
    }
}

struct SecondView: View {
    @ObservedObject var expenses: Expenses

    @Environment(\.dismiss) var dismiss

    var body: some View {

        Button("Dismiss") {
            expenses.items
                .append(ExpenseItem(name: "new expense", type: "private", amount: 10))
            dismiss()
        }
    }
}

struct iExpense_Previews: PreviewProvider {
    static var previews: some View {
        iExpense()
    }
}
