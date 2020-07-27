//
//  CheckedCarsModel.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 7/17/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation

class CheckedCarsModel: NSObject{

//properties
var year: String!
var make: String!
var model: String!
var style: String!
var odometer: String!
var color: String!
var grade: String!
var runNumber: String!
var vin: String!
var baseMMR: String!
var adjustedMMR: String!
var lowRangeValue: String!
var highRangeValue: String!
var avgOdometer: String!
var avgCondition: String!
var rank: String!
var body: String!
var tires: String!
var interior: String!
var glass: String!
var battery: String!
var A_C_heat: String!
var engine: String!
var transmission: String!
var suspension: String!
var brakes: String!
var cooling: String!
    
    


//empty constructor
override init(){
    
}

    init(year:String, make:String, model:String, style:String, odometer:String, color:String, grade:String, runNumber:String, vin:String, baseMMR:String, adjustedMMR:String, lowRangeValue:String, highRangeValue:String, avgOdometer:String, avgCondition:String, rank:String, body:String, tires:String, interior:String,
         glass:String, battery:String, A_C_heat:String, engine:String, transmission:String, suspension:String, brakes:String, cooling:String){
    
    self.year = year
    self.make = make
    self.model = model
    self.style = style
    self.odometer = odometer
    self.color = color
    self.grade = grade
    self.runNumber = runNumber
    self.vin = vin
    self.baseMMR = baseMMR
    self.adjustedMMR = adjustedMMR
    self.lowRangeValue = lowRangeValue
    self.highRangeValue = highRangeValue
    self.avgOdometer = avgOdometer
    self.avgCondition = avgCondition
    self.rank = rank
    self.body = body
    self.tires = tires
    self.interior = interior
    self.glass = glass
    self.battery = battery
    self.A_C_heat = A_C_heat
    self.engine = engine
    self.transmission = transmission
    self.suspension = suspension
    self.brakes = brakes
    self.cooling = cooling
}

 //prints object's current state
   
   override var description: String {
       return "year: \(year), make: \(make), model: \(model), style: \(style), odometer: \(odometer), color: \(color), grade: \(grade), runNumber: \(runNumber), vin: \(vin), baseMMR: \(baseMMR), adjustedMMR: \(adjustedMMR), lowRangeValue: \(lowRangeValue), highRangeValue: \(highRangeValue), avgOdometer: \(avgOdometer), avgCondition: \(avgCondition), rank: \(rank), body: \(body), tires: \(tires), interior: \(interior), glass: \(glass), battery: \(battery), A_C_heat: \(A_C_heat), engine: \(engine), transmission: \(transmission), suspension: \(suspension), brakes: \(brakes), cooling: \(cooling)"
       
   }}
