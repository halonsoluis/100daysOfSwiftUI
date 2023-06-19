// Created for hundredDaysSwiftUI in 2023
// Using Swift 5.0

import Foundation

struct Converter {

    static func convert(_ value: Double, from originalUnit: UnitTemperature, to destinationUnit: UnitTemperature) -> Double {
        if originalUnit == .celsius && destinationUnit == .farenheit {
            return (value * 9/5) + 32
        }

        if originalUnit == .celsius && destinationUnit == .kelvin {
            return value + 273.15
        }

        if originalUnit == .farenheit && destinationUnit == .celsius {
            return (value-32) * (5/9)
        }

        if originalUnit == .farenheit && destinationUnit == .kelvin {
            return (value-32) * (5/9) + 273.15
        }

        if originalUnit == .kelvin && destinationUnit == .celsius {
            return value - 273.15
        }
        if originalUnit == .kelvin && destinationUnit == .farenheit {
            return (value-273.15) * (9/5) + 32
        }

        return value
    }
//
//    private func celsiusToFarenheit() -> Double {
//        (value * 9/5) + 32
//    }
//
//    private func celsiusToKelvin() -> Double {
//        value + 273.15
//    }
//
//    private func kelvinToCelsius() -> Double {
//        value - 273.15
//    }
//
//    private func farenheitToCelsius() -> Double {
//        (value-32) * (5/9)
//    }
//    private func farenheitToKelvin() -> Double {
//        (value-32) * (5/9) + 273.15
//    }
//
//    private func kelvinToFarenheit() -> Double {
//        (value-273.15) * (9/5) + 32
//    }
}
