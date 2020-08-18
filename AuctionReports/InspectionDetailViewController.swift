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
    
   
    //Button function for engine details
    @IBOutlet weak var engineComments: UIButton!
    @IBAction func engineComments(_ sender: Any) {
        var info = inspectedCar!.engine!
        let Rank = info.removeFirst()
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
    
    @IBOutlet weak var oneA: UIImageView!
    
    
    @IBOutlet weak var make_model: UILabel!
    @IBOutlet weak var lowRangeValue: UILabel!
    @IBOutlet weak var highRangeValue: UILabel!
    @IBOutlet weak var adjustedMMR: UILabel!
    
    override func viewDidLoad() {
        make_model.text = "\(String(describing: inspectedCar!.year!)) \(String(describing: inspectedCar!.make!)) \(String(describing: inspectedCar!.model!))"
        
        lowRangeValue.text = "\(String(describing: inspectedCar!.lowRangeValue!))"
        highRangeValue.text = "\(String(describing: inspectedCar!.highRangeValue!))"
        adjustedMMR.text = "\(String(describing: inspectedCar!.adjustedMMR!))"
        
    }
    
    func setStars(index:Int, rank:Int){
        
    }
}
