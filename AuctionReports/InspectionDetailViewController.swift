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
}
