//
//  InspectionDetailViewController.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 7/19/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation
import UIKit

class InspectionDetailViewController: UIViewController{
    
    var inspectedCar : CheckedCarsModel?
    
    var inspectionComment : UIAlertController?
    
 
    //Button function for engine comment details
    @IBOutlet weak var engineComments: UIButton!
    @IBAction func engineComments(_ sender: Any) {
        let info = inspectedCar!.engine!
        let comment = info.dropFirst(1)
        
        //create the alertController object
        inspectionComment = UIAlertController(
            title: "Engine",
            message: comment.base,
            preferredStyle: .alert)
        
        //create the close button
        let action = UIAlertAction(title: "Close", style: UIAlertAction.Style.default)
        
        //present the alert message
        inspectionComment?.addAction(action)
        self.present(inspectionComment!, animated:true, completion: nil)
    }
    
//Outlets for the stars under -engine-
    @IBOutlet weak var oneA: UIImageView!
    @IBOutlet weak var oneB: UIImageView!
    @IBOutlet weak var oneC: UIImageView!
    @IBOutlet weak var oneD: UIImageView!
    @IBOutlet weak var oneE: UIImageView!
    
//Outlets for the stars under -Transmission-
    @IBOutlet weak var twoA: UIImageView!
    @IBOutlet weak var twoB: UIImageView!
    @IBOutlet weak var twoC: UIImageView!
    @IBOutlet weak var twoD: UIImageView!
    @IBOutlet weak var twoE: UIImageView!
    
//Outlets for the stars under -Suspension-
    @IBOutlet weak var threeA: UIImageView!
    @IBOutlet weak var threeB: UIImageView!
    @IBOutlet weak var threeC: UIImageView!
    @IBOutlet weak var threeD: UIImageView!
    @IBOutlet weak var threeE: UIImageView!
    
//Outlets for the stars under -Body-
    @IBOutlet weak var fourA: UIImageView!
    @IBOutlet weak var fourB: UIImageView!
    
    @IBOutlet weak var fourC: UIImageView!
    @IBOutlet weak var fourD: UIImageView!
    @IBOutlet weak var fourE: UIImageView!
    
    
//Outlets for the stars under -Interior-
    @IBOutlet weak var fiveA: UIImageView!
    @IBOutlet weak var fiveB: UIImageView!
    @IBOutlet weak var fiveC: UIImageView!
    @IBOutlet weak var fiveD: UIImageView!
    @IBOutlet weak var fiveE: UIImageView!

    
//Outlets for the stars under Tires

    @IBOutlet weak var sixA: UIImageView!
    @IBOutlet weak var sixB: UIImageView!
    @IBOutlet weak var sixC: UIImageView!
    @IBOutlet weak var sixD: UIImageView!
    @IBOutlet weak var sixE: UIImageView!
    

//Outlets for the stars under brakes
    @IBOutlet weak var sevenA: UIImageView!
    @IBOutlet weak var sevenB: UIImageView!
    @IBOutlet weak var sevenC: UIImageView!
    @IBOutlet weak var sevenD: UIImageView!
    @IBOutlet weak var sevenE: UIImageView!
    
//Outlets for the stars under Cooling System
    @IBOutlet weak var eightA: UIImageView!
    @IBOutlet weak var eightB: UIImageView!
    @IBOutlet weak var eightC: UIImageView!
    @IBOutlet weak var eightD: UIImageView!
    @IBOutlet weak var eightE: UIImageView!
    
//Outlets for the stars under Glass
    @IBOutlet weak var nineA: UIImageView!
    @IBOutlet weak var nineB: UIImageView!
    @IBOutlet weak var nineC: UIImageView!
    @IBOutlet weak var nineD: UIImageView!
    @IBOutlet weak var nineE: UIImageView!
    
    
//Outlets fot the stars under Battery
    @IBOutlet weak var tenA: UIImageView!
    @IBOutlet weak var tenB: UIImageView!
    @IBOutlet weak var tenC: UIImageView!
    @IBOutlet weak var tenD: UIImageView!
    @IBOutlet weak var tenE: UIImageView!
    
//Outlets for the stars under A/C - Heat
    @IBOutlet weak var elevenA: UIImageView!
    @IBOutlet weak var elevenB: UIImageView!
    @IBOutlet weak var elevenC: UIImageView!
    @IBOutlet weak var elevenD: UIImageView!
    @IBOutlet weak var elevenE: UIImageView!
    
    @IBOutlet weak var make_model: UILabel!
    @IBOutlet weak var lowRangeValue: UILabel!
    @IBOutlet weak var highRangeValue: UILabel!
    @IBOutlet weak var adjustedMMR: UILabel!
    

    
    override func viewDidLoad() {
        
        //Populate the inspection Report with the appropriate details for the selected car
        make_model.text = "\(String(describing: inspectedCar!.year!)) \(String(describing: inspectedCar!.make!)) \(String(describing: inspectedCar!.model!))"
        lowRangeValue.text = "\(String(describing: inspectedCar!.lowRangeValue!))"
        highRangeValue.text = "\(String(describing: inspectedCar!.highRangeValue!))"
        adjustedMMR.text = "\(String(describing: inspectedCar!.adjustedMMR!))"
        
        
        let engineOutletDict: [Int:UIImageView] = [1: oneA, 2: oneB, 3: oneC, 4: oneD, 5: oneE]
        var engineInfo = inspectedCar!.engine!
        let engineRank = engineInfo.removeFirst()
        setStars(rank: engineRank.wholeNumberValue!, stars: engineOutletDict)
        
        
        let transOutletDict: [Int:UIImageView] = [1:twoA, 2:twoB, 3:twoC, 4:twoD, 5:twoE]
        var transInfo = inspectedCar!.transmission!
        let transRank = transInfo.removeFirst()
        setStars(rank:transRank.wholeNumberValue!, stars:transOutletDict)
        
        let suspOutletDict: [Int:UIImageView] = [1:threeA, 2:threeB, 3:threeC, 4:threeD, 5:threeE]
        var suspInfo = inspectedCar!.suspension!
        let suspRank = suspInfo.removeFirst()
        setStars(rank:suspRank.wholeNumberValue!, stars:suspOutletDict)
        
        let bodyOutletDict: [Int:UIImageView] = [1:fourA, 2:fourB, 3:fourC, 4:fourD, 5:fourE]
        var bodyInfo = inspectedCar!.body!
        let bodyRank = bodyInfo.removeFirst()
        setStars(rank:bodyRank.wholeNumberValue!,stars: bodyOutletDict)
        
        let interiorOutletDict: [Int:UIImageView] = [1:fiveA, 2:fiveB, 3:fiveC, 4:fiveD, 5:fiveE]
        var interiorInfo = inspectedCar!.interior!
        let interiorRank = interiorInfo.removeFirst()
        setStars(rank:interiorRank.wholeNumberValue!, stars: interiorOutletDict)
        
        let tiresOutletDict: [Int:UIImageView] = [1:sixA, 2:sixB, 3:sixC, 4:sixD, 5:sixE]
        var tiresInfo = inspectedCar!.tires!
        let tiresRank = tiresInfo.removeFirst()
        setStars(rank:tiresRank.wholeNumberValue!, stars: tiresOutletDict)
        
        let brakesOutletDict: [Int:UIImageView] = [1:sevenA, 2:sevenB, 3:sevenC, 4:sevenD, 5:sevenE]
        var brakesInfo = inspectedCar!.brakes!
        let brakesRank = brakesInfo.removeFirst()
        setStars(rank:brakesRank.wholeNumberValue!, stars: brakesOutletDict)
        
        let coolingOutletDict: [Int:UIImageView] = [1:eightA, 2:eightB, 3:eightC, 4:eightD, 5:eightE]
        var coolingInfo = inspectedCar!.cooling!
        let coolingRank = coolingInfo.removeFirst()
        setStars(rank:coolingRank.wholeNumberValue!, stars: coolingOutletDict)
        
        let glassOutletDict: [Int:UIImageView] = [1:nineA, 2:nineB, 3:nineC, 4:nineD, 5:nineE]
        var glassInfo = inspectedCar!.glass!
        let glassRank = glassInfo.removeFirst()
        setStars(rank:glassRank.wholeNumberValue!, stars: glassOutletDict)
        
        let batteryOutletDict: [Int:UIImageView] = [1:tenA, 2:tenB, 3:tenC, 4:tenD, 5:tenE]
        var batteryInfo = inspectedCar!.battery!
        let batteryRank = batteryInfo.removeFirst()
        setStars(rank:batteryRank.wholeNumberValue!, stars: batteryOutletDict)
        
        let A_C_heatOutletDict: [Int:UIImageView] = [1:elevenA, 2:elevenB, 3:elevenC, 4:elevenD, 5:elevenE]
        var A_C_heatInfo = inspectedCar!.A_C_heat!
        let A_C_heatRank = A_C_heatInfo.removeFirst()
        setStars(rank:A_C_heatRank.wholeNumberValue!, stars: A_C_heatOutletDict)
        
            
    }
    
    //Sets the number of stars for a given field
    func setStars(rank:Int, stars: Dictionary<Int, UIImageView>){
        
        for x in 1...rank{
            stars[x]!.image = UIImage(systemName:"star.fill")
        }
    }
}
