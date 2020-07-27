//
//  ReportModel.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 7/17/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation
protocol ReportModelProtocol: class {
    func itemsDownloaded(items: NSMutableArray)
}

class ReportModel: NSObject, URLSessionDataDelegate {
    
    var jsonElement = NSDictionary()
    
    let checkedCars = NSMutableArray()
    
    weak var delegate: ReportModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "https://www.wlgenerator.tech/service2.php"
    
    func downloadItems(){
        
        checkedCars.removeAllObjects()
        
        guard let url : URL = URL(string: urlPath) else{
            return
        }
        
        let request = NSMutableURLRequest(url:url)
        request.cachePolicy = .reloadIgnoringCacheData
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
           
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
               
               if error != nil {
                   print("Failed to download data")
               }else {
                   print("Data downloaded")
                   self.parseJSON(data!)
               }
               
           }
        
        task.resume()
    }
    
    
    func parseJSON(_ data:Data) {
            
            var jsonResult = NSArray()
            
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                
            } catch let error as NSError {
                print(error)
                
            }
            
            
            for i in 0 ..< jsonResult.count
            {
                
                jsonElement = jsonResult[i] as! NSDictionary
                

                  let checkedCar = CheckedCarsModel()
                
                //the following insures none of the JsonElement values are nil through optional binding
                   if let year = jsonElement["year"] as? String,
                    let make = jsonElement["make"] as? String,
                    let model = jsonElement["model"] as? String,
                    let style = jsonElement["style"] as? String,
                    let odometer = jsonElement["odometer"] as? String,
                    let color = jsonElement["color"] as? String,
                    let grade = jsonElement["grade"] as? String,
                    let runNumber = jsonElement["runNumber"] as? String,
                    let vin = jsonElement["vin"] as? String,
                    let baseMMR = jsonElement["baseMMR"] as? String,
                    let adjustedMMR = jsonElement["adjustedMMR"] as? String,
                    let lowRangeValue = jsonElement["lowRangeValue"] as? String,
                    let highRangeValue = jsonElement["highRangeValue"] as? String,
                    let avgOdometer = jsonElement["avgOdometer"] as? String,
                    let avgCondition = jsonElement["avgCondition"] as? String,
                    let rank = jsonElement["rank"] as? String,
                    let body = jsonElement["body"] as? String,
                    let tires = jsonElement["tires"] as? String,
                    let interior = jsonElement["interior"] as? String,
                    let glass = jsonElement["glass"] as? String,
                    let battery = jsonElement["battery"] as? String,
                    let A_C_heat = jsonElement["A_C_heat"] as? String,
                    let engine = jsonElement["engine"] as? String,
                    let transmission = jsonElement["transmission"] as? String,
                    let suspension = jsonElement["suspension"] as? String,
                    let brakes = jsonElement["brakes"] as? String,
                    let cooling = jsonElement["cooling"] as? String
                    
                    
                {
                    
                    
                    checkedCar.year = year
                    checkedCar.make = make
                    checkedCar.model = model
                    checkedCar.style = style
                    checkedCar.odometer = odometer
                    checkedCar.color = color
                    checkedCar.grade = grade
                    checkedCar.runNumber = runNumber
                    checkedCar.vin = vin
                    checkedCar.baseMMR = baseMMR
                    checkedCar.adjustedMMR = adjustedMMR
                    checkedCar.lowRangeValue = lowRangeValue
                    checkedCar.highRangeValue = highRangeValue
                    checkedCar.avgOdometer = avgOdometer
                    checkedCar.avgCondition = avgCondition
                    checkedCar.rank = rank
                    checkedCar.body = body
                    checkedCar.tires = tires
                    checkedCar.interior = interior
                    checkedCar.glass = glass
                    checkedCar.battery = battery
                    checkedCar.A_C_heat = A_C_heat
                    checkedCar.engine = engine
                    checkedCar.transmission = transmission
                    checkedCar.suspension = suspension
                    checkedCar.brakes = brakes
                    checkedCar.cooling = cooling
                    
                    
                }
                
                checkedCars.add(checkedCar)
                
            }
            
            
            print("fuck you")
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.delegate.itemsDownloaded(items: self.checkedCars)
                
            })
        }
    
    
    
}
