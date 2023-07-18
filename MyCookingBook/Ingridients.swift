enum MeasuresOfMeasurement {
    case weight(Double, String)
    case volume(Double, String)
    case amount(Double, String)
    
    static func defaultStringValue(for measuresOfMeasurement: MeasuresOfMeasurement) -> String {
        switch measuresOfMeasurement {
        case .weight:
            return "kg"
        case .volume:
            return "liters"
        case .amount:
            return "thing"
        }
    }
    
    init(weight: Double) {
        self = .weight(weight, "kg")
    }
    
    init(volume: Double) {
        self = .volume(volume, "liters")
    }
    
    init(amount: Double) {
        self = .amount(amount, "thing")
    }
}

struct Ingridients {
    let type: String
    let measuresOfMeasurement: MeasuresOfMeasurement
}
