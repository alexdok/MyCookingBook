enum MeasuresOfMeasurement {
    
    case weight(Double, String)
    case volume(Double, String)
    case pieces(Double, String)
    
    init(weight: Double) {
        self = .weight(weight, "kilograms")
    }
    
    init(volume: Double) {
        self = .volume(volume, "liters")
    }
    
    init(amount: Double) {
        self = .pieces(amount, "pices")
    }
}

struct Ingridient {
    let type: String
    let measuresOfMeasurement: MeasuresOfMeasurement
}
