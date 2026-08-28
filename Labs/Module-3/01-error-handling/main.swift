enum CalculatorError: Error {
    case divisionByZero
}

func divide(_ dividend: Double, by divisor: Double) throws -> Double {
    guard divisor != 0 else {
        throw CalculatorError.divisionByZero
    }

    return dividend / divisor
}

do {
    print(try divide(10, by: 2))
    _ = try divide(10, by: 0)
} catch CalculatorError.divisionByZero {
    print("Division by zero is not allowed")
} catch {
    print("Unexpected error: \(error)")
}
