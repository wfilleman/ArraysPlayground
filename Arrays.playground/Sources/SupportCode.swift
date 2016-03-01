import Foundation

// Open Weather Map API Key
public let openWeatherAPIKey = ""

// City IDs for Weather API
// Scottsdale, AZ = 5313457
// Gilbert, AZ = 5295903
// Flagstaff, AZ = 5294810
// New York, NY = 5128638
public let cityID = "5313457"


// Functions
// - Convert Kelvin to Fahrenheit
public func KtoF(kelvin:NSNumber) -> NSNumber {
    return NSNumber (integer:Int((kelvin.doubleValue - 273.15) * 1.8 + 32.00))
}
// - Convert meters to miles
public func metersToMilesPerHour(meters:NSNumber) -> NSNumber {
    return NSNumber(double: (meters.doubleValue * 0.00062137) * 60 * 60)
}

// Double Extension to limit the returned number of decimal places
extension Double {
    /// Rounds the double to decimal places value
    public func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}