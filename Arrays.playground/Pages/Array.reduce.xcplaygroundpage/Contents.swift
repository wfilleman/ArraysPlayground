//: [Previous](@previous)

//: ## Swift Array.reduce
//: * Use real weather data to convert into an averaged temp value for the next 5 days.
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
returnWeatherForecast()
    .then { weatherJSON -> Void in
        
        // Example:
        // .map out the temp forecasted data in Fahrenheit
        let tempForecast = weatherJSON["list"].arrayValue.map { listObj -> NSNumber in
            
            // Pull out the temp. Results are in kelvin
            let maxTemp = listObj["main"]["temp_max"].numberValue
            
            // Return the max temp as a NSNumber in Fahrenheit.
            return KtoF(maxTemp)
        }
        
        print("Temp Forcasted Array: \(tempForecast)") // Look at the Log for results
        
        // .reduce takes two parameters:
        //      The Initial Value to start the reduction
        //      combine: firstElement and the next element to operate over
        // and returns a final Type. In this case of type NSNumber.
        
        // START Exercise: .reduce the "tempForecast" array into the average forecasted temp.
        var averageTemp = NSNumber(double: 0.0)
        
        // REPLACE WITH YOUR CODE
        
        // END Excercise Code

        // Setup the label
        let averageTempLbl = UILabel(frame: CGRectMake(0,0,300,50))
        averageTempLbl.textAlignment = .Center
        averageTempLbl.backgroundColor = [#Color(colorLiteralRed: 0, green: 1, blue: 0.1411310552024592, alpha: 1)#]
        averageTempLbl.text = "Average Forecasted Temp is \(averageTemp.doubleValue.roundToPlaces(1))°"
        
        averageTempLbl
        
        
        // START Exercise: Show just the afternoon average temp.
        
        // REPLACE WITH YOUR CODE
        
        // END Excercise Code
    }
    .error { error in
        print(error)
}

