// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

struct Conversion: View {
    @State private var originalUnit: UnitTemperature = .celsius
    @State private var destinationUnit: UnitTemperature = .fahrenheit
    @State private var value: Double = 0

    private let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]

    @FocusState private var amountIsFocused: Bool

    var body: some View {
        NavigationView {
            Form {

                Section("Select original unit") {
                    Picker("original unit", selection: $originalUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Select destination unit") {
                    Picker("original unit", selection: $destinationUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Original Amount") {
                    TextField("Original Amount", value: $value, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }

                Section("Translated Amount") {
                    Text(convertedAmount, format: .number)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }.navigationTitle("Temperature conversion")

    }

    private var convertedAmount: Double {
        NSMeasurement(
            doubleValue: value,
            unit: originalUnit
        )
        .converting(to: destinationUnit)
        .value
    }
}

struct Conversion_Previews: PreviewProvider {
    static var previews: some View {
        Conversion()
    }
}
