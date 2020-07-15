//
//  InspectionViewController.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 7/2/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation
import UIKit
var page = 1
class InspectionViewController : UIViewController{
    
    var selectedCar : UncheckedCarsModel?
    
    var selectedRow : IndexPath?
    
    var checkList : [Int:Int]?
    
    var commentsList : [Int:String]?
    
    var alertController: UIAlertController?
    
    var carsTable: ViewController? //holds the viewcontroller that is connected to the
                                   //list of uninspected cars.
    

    @IBOutlet weak var commentsAlert: UIButton!
    
    //This is the popup that shows when you click the label button
    @IBAction func commentsAlert(_ sender: UIButton) {
        
        alertController = UIAlertController(title: "Comments", message: "Enter any comments below", preferredStyle: .alert)
        
        //Any page with no comments is left unspecified
        alertController?.addTextField(
            configurationHandler: {(textField: UITextField!) in textField.placeholder = "Unspecified"})
        
        let action = UIAlertAction(title: "Submit",
                                   style: UIAlertAction.Style.default,
                                   handler: {[weak self]
                                    (paramAction: UIAlertAction!) in if let textFields = self?.alertController?.textFields{
                                        let theTextFields = textFields as [UITextField]
                                        let enteredText = theTextFields[0].text
                                        self?.commentsList!.updateValue(enteredText!, forKey: page)                                                             }
                                           })
        
        alertController?.addAction(action)
        self.present(alertController!, animated:true, completion: nil)
        
    }
    
    
    
    //defining how the numbered buttons function
    @IBOutlet weak var rating1: UIButton!
    
    @IBAction func rating1(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(rating2.isSelected){
            rating2.isSelected = !rating2.isSelected
        }
        if(rating3.isSelected){
            rating3.isSelected = !rating3.isSelected
        }
        if(rating4.isSelected){
            rating4.isSelected = !rating4.isSelected
        }
        if(rating5.isSelected){
            rating5.isSelected = !rating5.isSelected
        }
    }
    
    @IBOutlet weak var rating2: UIButton!
    
    @IBAction func rating2(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(rating1.isSelected){
            rating1.isSelected = !rating1.isSelected
        }
        if(rating3.isSelected){
            rating3.isSelected = !rating3.isSelected
        }
        if(rating4.isSelected){
            rating4.isSelected = !rating4.isSelected
        }
        if(rating5.isSelected){
            rating5.isSelected = !rating5.isSelected
        }
    }
    
    
    @IBOutlet weak var rating3: UIButton!
    
    @IBAction func rating3(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(rating2.isSelected){
            rating2.isSelected = !rating2.isSelected
        }
        if(rating1.isSelected){
            rating3.isSelected = !rating3.isSelected
        }
        if(rating4.isSelected){
            rating4.isSelected = !rating4.isSelected
        }
        if(rating5.isSelected){
            rating5.isSelected = !rating5.isSelected
        }
    }
    
    
    @IBOutlet weak var rating4: UIButton!
    
    @IBAction func rating4(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(rating2.isSelected){
            rating2.isSelected = !rating2.isSelected
        }
        if(rating3.isSelected){
            rating3.isSelected = !rating3.isSelected
        }
        if(rating1.isSelected){
            rating4.isSelected = !rating4.isSelected
        }
        if(rating5.isSelected){
            rating5.isSelected = !rating5.isSelected
        }
    }
    
    @IBOutlet weak var rating5: UIButton!
    
    @IBAction func rating5(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(rating2.isSelected){
            rating2.isSelected = !rating2.isSelected
        }
        if(rating3.isSelected){
            rating3.isSelected = !rating3.isSelected
        }
        if(rating4.isSelected){
            rating4.isSelected = !rating4.isSelected
        }
        if(rating1.isSelected){
            rating5.isSelected = !rating5.isSelected
        }
    }
    
    //Outlet and action function for the continue button. Used in every modal except the last
    @IBOutlet weak var continueButton: UIButton!
    @IBAction func continueButton(_ sender: Any) {
        
        //Check which button was selected before continuing to the next page
        print(self.commentsList![page]! as Any)
        
        if(rating1.isSelected){
            _ = checkList!.updateValue(1, forKey: page)
            page += 1
        }else if(rating2.isSelected){
            _ = checkList!.updateValue(2, forKey: page)
            page += 1
        }else if(rating3.isSelected){
            _ = checkList!.updateValue(3, forKey: page)
            page += 1
        }else if(rating4.isSelected){
            _ = checkList!.updateValue(4, forKey: page)
            page += 1
        }else if(rating5.isSelected){
            _ = checkList!.updateValue(5, forKey: page)
            page += 1
        }else{
            return
        }
  
        
        //create identifier for the next segue by inserting the page number
        var identifier = "InspectionSegue"
        let index = identifier.index(identifier.startIndex, offsetBy: 10)
             identifier.insert(contentsOf: "\(page)", at: index)
             print(identifier)
         
         //If it is not the last inspection modal, segue to the next.
        if(identifier != "Inspection12Segue"){
            self.performSegue(withIdentifier:identifier, sender: self)
        }else{
            
            //Send the data off to the database and unwind back to the list of uninspected cars
            let sendData = sendtoDB()
            sendData.exportData(selectedCar: self.selectedCar, checkList:
            self.checkList!,commentsList: self.commentsList!)
            
            self.performSegue(withIdentifier:"unwindToCars", sender:self)
    }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.destination is InspectionViewController{


            // Get reference to the destination view controller
            let inspectionVC = segue.destination as? InspectionViewController
        
            // Pass along the properties to the next InspectionViewController
            inspectionVC?.selectedCar = self.selectedCar
            inspectionVC?.checkList = self.checkList
            inspectionVC?.commentsList = self.commentsList

 }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define the button properties for the numbered buttons
        rating1.setImage(UIImage(systemName:"1.circle"), for: .normal)
        rating1.setImage(UIImage(systemName:"1.circle.fill"), for: .selected)
        rating1.addTarget(self, action: #selector(getter: self.rating1), for: UIControl.Event.touchUpInside)
        
        
        rating2.setImage(UIImage(systemName:"2.circle"), for: .normal)
        rating2.setImage(UIImage(systemName:"2.circle.fill"), for: .selected)
        rating2.addTarget(self, action: #selector(getter: self.rating2), for: UIControl.Event.touchUpInside)
        
        rating3.setImage(UIImage(systemName:"3.circle"), for: .normal)
        rating3.setImage(UIImage(systemName:"3.circle.fill"), for: .selected)
        rating3.addTarget(self, action: #selector(getter: self.rating3), for: UIControl.Event.touchUpInside)
        
        rating4.setImage(UIImage(systemName:"4.circle"), for: .normal)
        rating4.setImage(UIImage(systemName:"4.circle.fill"), for: .selected)
        rating4.addTarget(self, action: #selector(getter: self.rating4), for: UIControl.Event.touchUpInside)
        
        rating5.setImage(UIImage(systemName:"5.circle"), for: .normal)
        rating5.setImage(UIImage(systemName:"5.circle.fill"), for: .selected)
        rating5.addTarget(self, action: #selector(getter: self.rating5), for: UIControl.Event.touchUpInside)
        
        
        }
    
    //decrement the page number when dismissing a modal
    override func viewDidDisappear(_ animated: Bool) {
        if(page != 1){
           
            page -= 1
            
            
        }
    }
   
    
    
}
    
    

