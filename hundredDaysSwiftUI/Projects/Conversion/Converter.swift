// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import Foundation

fileprivate extension UnitTemperature {
    var toNSUnitTemperature: Foundation.UnitTemperature {
        switch self {
        case .celsius: return Foundation.UnitTemperature.celsius
        case .farenheit: return Foundation.UnitTemperature.fahrenheit
        case .kelvin: return Foundation.UnitTemperature.kelvin
        }
    }
}

struct Converter {

    static func convert(
        _ value: Double,
        from originalUnit: UnitTemperature,
        to destinationUnit: UnitTemperature) -> Double {

        let measurement = NSMeasurement(doubleValue: value, unit: originalUnit.toNSUnitTemperature)
        let newValue = measurement.converting(to: destinationUnit.toNSUnitTemperature)

        return newValue.value
    }
}
