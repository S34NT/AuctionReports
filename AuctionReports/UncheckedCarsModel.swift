//
//  UncheckedCarsModel.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 6/29/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation

class UncheckedCarsModel: NSObject{
    
    //properties
    var pictureCount: String!
    var CR: String!
    var year: String!
    var make: String!
    var model: String!
    var style: String!
    var odometer: String!
    var color: String!
    var stockNumber: String!
    var grade: String!
    var saleDate: String!
    var runNumber: String!
    var lane: String!
    var lot: String!
    var vin: String!
    var baseMMR: String!
    var adjustedMMR: String!
    var lowRangeValue: String!
    var highRangeValue: String!
    var avgOdometer: String!
    var avgCondition: String!
    var rank: String!
    

    //empty constructor
    override init(){
        
    }
    
    init(pictureCount:String, CR:String, year:String, make:String, model:String, style:String, odometer:String, color:String, stockNumber:String, grade:String, saleDate:String, runNumber:String, lane:String, lot:String, vin:String, baseMMR:String, adjustedMMR:String, lowRangeValue:String, highRangeValue:String, avgOdometer:String, avgCondition:String, rank:String){
        
        self.pictureCount = pictureCount
        self.CR = CR
        self.year = year
        self.make = make
        self.model = model
        self.style = style
        self.odometer = odometer
        self.color = color
        self.stockNumber = stockNumber
        self.grade = grade
        self.saleDate = saleDate
        self.runNumber = runNumber
        self.lane = lane
        self.lot = lot
        self.vin = vin
        self.baseMMR = baseMMR
        self.adjustedMMR = adjustedMMR
        self.lowRangeValue = lowRangeValue
        self.highRangeValue = highRangeValue
        self.avgOdometer = avgOdometer
        self.avgCondition = avgCondition
        self.rank = rank
    }
    
     //prints object's current state
       
       override var description: String {
           return "pictureCount: \(pictureCount), CR: \(CR), year: \(year), make: \(make), model: \(model), style: \(style), odometer: \(odometer), color: \(color), stockNumber: \(stockNumber), grade: \(grade), saleDate: \(saleDate), runNumber: \(runNumber), lane: \(lane), lot: \(lot), vin: \(vin), baseMMR: \(baseMMR), adjustedMMR: \(adjustedMMR), lowRangeValue: \(lowRangeValue), highRangeValue: \(highRangeValue), avgOdometer: \(avgOdometer), avgCondition: \(avgCondition), rank: \(rank) "
           
       }}
