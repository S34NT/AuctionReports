//
//  HomeModel.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 6/29/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSMutableArray)
}

class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    var jsonElement = NSDictionary()
    
    let uncheckedCars = NSMutableArray()
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "https://www.wlgenerator.tech/service.php"
    
    func downloadItems() {
    
    let url: URL = URL(string: urlPath)!
    let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
    
    let task = defaultSession.dataTask(with: url) { (data, response, error) in
        
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
        
//        var jsonElement = NSDictionary()
//        let uncheckedCars = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let uncheckedCar = UncheckedCarsModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let pictureCount = jsonElement["pictureCount"] as? String,
                let CR = jsonElement["CR"] as? String,
                let year = jsonElement["year"] as? String,
                let make = jsonElement["make"] as? String,
                let model = jsonElement["model"] as? String,
                let style = jsonElement["style"] as? String,
                let odometer = jsonElement["odometer"] as? String,
                let color = jsonElement["color"] as? String,
                let stockNumber = jsonElement["stockNumber"] as? String,
                let grade = jsonElement["grade"] as? String,
                let saleDate = jsonElement["saleDate"] as? String,
                let runNumber = jsonElement["runNumber"] as? String,
                let lane = jsonElement["lane"] as? String,
                let lot = jsonElement["lot"] as? String,
                let vin = jsonElement["vin"] as? String,
                let baseMMR = jsonElement["baseMMR"] as? String,
                let adjustedMMR = jsonElement["adjustedMMR"] as? String,
                let lowRangeValue = jsonElement["lowRangeValue"] as? String,
                let highRangeValue = jsonElement["highRangeValue"] as? String,
                let avgOdometer = jsonElement["avgOdometer"] as? String,
                let avgCondition = jsonElement["avgCondition"] as? String,
                let rank = jsonElement["rank"] as? String
                
            {
                
                uncheckedCar.pictureCount = pictureCount
                uncheckedCar.CR = CR
                uncheckedCar.year = year
                uncheckedCar.make = make
                uncheckedCar.model = model
                uncheckedCar.style = style
                uncheckedCar.odometer = odometer
                uncheckedCar.color = color
                uncheckedCar.stockNumber = stockNumber
                uncheckedCar.grade = grade
                uncheckedCar.saleDate = saleDate
                uncheckedCar.runNumber = runNumber
                uncheckedCar.lane = lane
                uncheckedCar.lot = lot
                uncheckedCar.vin = vin
                uncheckedCar.baseMMR = baseMMR
                uncheckedCar.adjustedMMR = adjustedMMR
                uncheckedCar.lowRangeValue = lowRangeValue
                uncheckedCar.highRangeValue = highRangeValue
                uncheckedCar.avgOdometer = avgOdometer
                uncheckedCar.avgCondition = avgCondition
                uncheckedCar.rank = rank
                
                
            }
            
            uncheckedCars.add(uncheckedCar)
            
        }
        
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: self.uncheckedCars)
            
        })
    }
    
    func getDownloadedItems(){
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: self.uncheckedCars)
            
        })
    }
}
