//: [Previous](@previous)

//: ## Swift Array.filter
//: * Use real weather data to convert into a filtered array for use by a caller.
//: * Use the results to display to the user in a UILabel.

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit
import SwiftDate

//: Promised function to return just the Forecasted data over the next 5 days every three hours.
func returnWeatherForecast() -> Promise<JSON> {
    
    return Promise { fulfill, rejected in
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/forecast?id=\(cityID)&APPID=\(openWeatherAPIKey)").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    fulfill(json)
                }
            case .Failure(let error):
                print(error)
                rejected(error)
            }
        }
    }
}

//: ## Entry Point

// The speed in Miles per Hour considered windy
let windySpeed = 10.0

returnWeatherForecast()
    .then { weatherJSON -> Void in
        
        // Example:
        // .map out the wind speed data in miles per hour associated with the date value as a tuple.
        let windSpeedForecast = weatherJSON["list"].arrayValue.map { listObj -> (wind:NSNumber, date:NSDate) in
            
            // Pull out the wind speed. Results are in meters/second
            let windSpeed = listObj["wind"]["speed"].numberValue
            let dateStamp = listObj["dt"].numberValue
            let date = NSDate(timeIntervalSince1970: dateStamp.doubleValue)
            
            // Return the wind speed in miles per hour as a NSNumber along with the date.
            return (metersToMilesPerHour(windSpeed), date)
        }
        
        print("All Forecasted Wind Speeds: \(windSpeedForecast)") // Look at the Log for results
        
        // START Exercise: Filter the "windSpeedForecast" to just include forecasted data from today that is greater than "windySpeed"
        // * Hint on the Date: Look at the NSDate Extensions in SwiftDate for the ".inInToday" extension feature.
        var windSpeedsFilteredForecast = [(wind:NSNumber, date:NSDate)]()
        
        // REPLACE WITH YOUR CODE
        
        // END Excercise Code
        
        print("Filtered Wind Speeds: \(windSpeedsFilteredForecast)") // Look at the Log for results
        
        let windyLbl = UILabel(frame: CGRectMake(0,0,300,50))
        windyLbl.textAlignment = .Center
        if windSpeedsFilteredForecast.count > 0 {
            windyLbl.text = "It's Windy TODAY!"
            windyLbl.backgroundColor = [#Color(colorLiteralRed: 1, green: 0, blue: 0, alpha: 1)#]
            windyLbl.textColor = [#Color(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)#]
        } else {
            windyLbl.text = "It is not windy today"
            windyLbl.backgroundColor = [#Color(colorLiteralRed: 0, green: 1, blue: 0.1411310552024592, alpha: 1)#]
        }
        windyLbl
        
        
        // START Exercise: Display a label showing all the weather[].descriptions for tomorrow

        // REPLACE WITH YOUR CODE
        
        // End Excercise Code
        
    }
    .error { error in
        print(error)
}

//: [Next](@next)
