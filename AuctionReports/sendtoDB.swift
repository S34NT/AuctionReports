//
//  sendtoDB.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 7/11/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation
import UIKit

class sendtoDB:NSObject, URLSessionDelegate{
    
    func exportData(selectedCar: UncheckedCarsModel?, checkList: [Int:Int], commentsList: [Int:String]){
        
        let url = NSURL(string:"https://www.wlgenerator.tech/export.php")
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        var dataString = "secretWord=009u0x489a"
        
        dataString = dataString + "&make=\(selectedCar!.make!)"
        dataString = dataString + "&model=\(selectedCar!.model!)"
        dataString = dataString + "&year=\(selectedCar!.year!)"
        dataString = dataString + "&style=\(selectedCar!.style!)"
        dataString = dataString + "&color=\(selectedCar!.color!)"
        dataString = dataString + "&odometer=\(selectedCar!.odometer!)"
        dataString = dataString + "&grade=\(selectedCar!.grade!)"
        dataString = dataString + "&vin=\(selectedCar!.vin!)"
        dataString = dataString + "&runNumber=\(selectedCar!.runNumber!)"
        dataString = dataString + "&baseMMR=\(selectedCar!.baseMMR!)"
        dataString = dataString + "&adjustedMMR=\(selectedCar!.adjustedMMR!)"
        dataString = dataString + "&lowRangeValue=\(selectedCar!.lowRangeValue!)"
        dataString = dataString + "&highRangeValue=\(selectedCar!.highRangeValue!)"
        dataString = dataString + "&avgOdometer= \(selectedCar!.avgOdometer!)"
        dataString = dataString + "&avgCondition=\(selectedCar!.avgCondition!)"
        dataString = dataString + "&rank=\(selectedCar!.rank!)"
        
        dataString = dataString + "&body=\(String(describing:checkList[1]!) + commentsList[1]!)"
        dataString = dataString + "&tires=\(String(describing:checkList[2]!) +  commentsList[2]!)"
        dataString = dataString + "&interior=\(String(describing:checkList[3]!) + commentsList[3]!)"
        dataString = dataString + "&glass=\(String(describing:checkList[4]!) +  commentsList[4]!)"
        dataString = dataString + "&battery=\(String(describing:checkList[5]!) +  commentsList[5]!)"
        dataString = dataString + "&A_C_heat=\(String(describing:checkList[6]!) +  commentsList[6]!)"
        dataString = dataString + "&engine=\(String(describing:checkList[7]!) +  commentsList[7]!)"
        dataString = dataString + "&transmission=\(String(describing:checkList[8]!) +  commentsList[8]!)"
        dataString = dataString + "&suspension=\(String(describing:checkList[9]!) +  commentsList[9]!)"
        dataString = dataString + "&brakes=\(String(describing:checkList[10]!) +  commentsList[10]!)"
        dataString = dataString + "&cooling=\(String(describing:checkList[11]!) +  commentsList[11]!)"
       
        
        //Convert the string to uft8
        let convertedData = dataString.data(using: .utf8)!
        
        let uploadJob = URLSession.shared.uploadTask(with: request, from: convertedData){

            data, response, error in

            if error != nil {

        // display an alert if there is an error inside the DispatchQueue.main.async

            DispatchQueue.main.async
            {
                    print("connection failed")
            }
        }
else
{
    if let unwrappedData = data {

        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database

        if returnedData == "1" // insert into database worked
        {

// display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
            DispatchQueue.main.async
            {
                print("insert was successful")
            }
        }
        else
        {
// display an alert if an error and database insert didn't work (return != 1) inside the DispatchQueue.main.async
            DispatchQueue.main.async
            {

            print("database insert was not successful")
            
                
                }
            }
        }
    }
}
                    uploadJob.resume()
            
    }
    
   
    
}
