//
//  DetailViewController.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 6/29/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController : UIViewController{
    
    var selectedCar : UncheckedCarsModel?
    var selectedRow : IndexPath?
    var check_List : [Int:Int]?
    var comments_List : [Int:String]?
    var buttonColor: UIColor?
   
   
    
    @IBOutlet weak var model: UILabel!
    
    @IBOutlet weak var make: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var run_number: UILabel!
    
    @IBOutlet weak var vin: UILabel!
    
    @IBOutlet weak var carButton: UIButton!
    
    
    
    @IBAction func carButton(_ sender: UIButton) {
        self.performSegue(withIdentifier:"Inspection1Segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is InspectionViewController{
            let check_List:[Int:Int] = [1: -1, 2: -1, 3: -1, 4: -1, 5: -1, 6: -1, 7: -1, 8: -1, 9: -1, 10: -1, 11: -1, 12: -1, 13: -1, 14: -1]
            let comments_List:[Int:String] = [1: "None", 2: "None", 3: "None", 4: "None", 5: "None", 6: "None", 7: "None", 8: "None", 9: "None", 10: "None", 11: "None", 12: "None", 13: "None", 14: "None"]
            
            
                // Get reference to the destination view controller
                let inspectionVC = segue.destination as? InspectionViewController
                //Set the properties for selectedCar and checkList so that the InspectionViewController can access them
                inspectionVC?.selectedCar = selectedCar
                inspectionVC?.commentsList = comments_List
                inspectionVC?.checkList = check_List
                inspectionVC?.selectedRow = selectedRow
                
                
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        make?.text = selectedCar?.make
        
        model?.text = selectedCar?.model
        
        year?.text = selectedCar?.year
        
        run_number?.text = selectedCar?.runNumber
        
        vin?.text = selectedCar?.vin
        
    }
    
}


