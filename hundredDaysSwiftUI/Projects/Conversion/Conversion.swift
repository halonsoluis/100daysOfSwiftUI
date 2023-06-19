// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import SwiftUI

enum UnitTemperature: String, CaseIterable {
    case celsius, farenheit, kelvin
}

struct Conversion: View {
    @State private var originalUnit: UnitTemperature = .celsius
    @State private var destinationUnit: UnitTemperature = .farenheit
    @State private var value: Double = 0

    var body: some View {
        NavigationView {
            Form {

                Section("Select original unit") {
                    Picker("original unit", selection: $originalUnit) {
                        ForEach(UnitTemperature.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Select destination unit") {
                    Picker("original unit", selection: $destinationUnit) {
                        ForEach(UnitTemperature.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Original Amount") {
                    TextField("Original Amount", value: $value, format: .number)
                        .textFieldStyle(.roundedBorder)
                }

                Section("Translated Amount") {
                    Text("\(convertedAmount)")
                }
            }

        }
        .navigationTitle("Temperature conversion")
    }

    var convertedAmount: Double {
        Converter.convert(value, from: originalUnit, to: destinationUnit)
    }
}

struct Conversion_Previews: PreviewProvider {
    static var previews: some View {
        Conversion()
    }
}
