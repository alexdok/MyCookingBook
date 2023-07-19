enum MeasuresOfMeasurement {
    case weight(Double, String)
    case volume(Double, String)
    case pices(Double, String)
    
    init(weight: Double) {
        self = .weight(weight, "kilograms")
    }
    
    init(volume: Double) {
        self = .volume(volume, "liters")
    }
    
    init(amount: Double) {
        self = .pices(amount, "pices")
    }
}

struct Ingridient {
    let type: String
    let measuresOfMeasurement: MeasuresOfMeasurement
}
