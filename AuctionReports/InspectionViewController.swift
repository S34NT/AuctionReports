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
    
    var carsTable: ViewController?
    
    @IBOutlet weak var commentsAlert: UIButton!
    
    @IBAction func commentsAlert(_ sender: UIButton) {
        
        alertController = UIAlertController(title: "Comments", message: "Enter any comments below", preferredStyle: .alert)
        
        alertController?.addTextField(
            configurationHandler: {(textField: UITextField!) in textField.placeholder = "None"})
        
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
    
    @IBOutlet weak var greenHexButton: UIButton!
    
    @IBAction func greenHexButton(_ sender: UIButton) {
        
         sender.isSelected = !sender.isSelected
        
        if(yellowHexButton.isSelected){
            yellowHexButton.isSelected = !yellowHexButton.isSelected
        }
        
        if(redHexButton.isSelected){
            redHexButton.isSelected = !redHexButton.isSelected
        }
        
    }
    
   
    @IBOutlet weak var yellowHexButton: UIButton!
    
    @IBAction func yellowHexButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(greenHexButton.isSelected){
            greenHexButton.isSelected = !greenHexButton.isSelected
        }
        
        if(redHexButton.isSelected){
            redHexButton.isSelected = !redHexButton.isSelected
        }
    }
    
    @IBOutlet weak var redHexButton: UIButton!
    
    @IBAction func redHexButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if(greenHexButton.isSelected){
            greenHexButton.isSelected = !greenHexButton.isSelected
        }
        
        if(yellowHexButton.isSelected){
            yellowHexButton.isSelected = !yellowHexButton.isSelected
        }    }
    
    
    //Outlet and action function for the continue button. Used in every modal except the last
    @IBOutlet weak var continueButton: UIButton!
    @IBAction func continueButton(_ sender: Any) {
        
    //Check which button was selected before continuing to the next page
        print(self.commentsList![page]! as Any)
        if(greenHexButton.isSelected){
            _ = checkList!.updateValue(1, forKey: page)
            print(self.checkList![page]! as Any)
            page += 1
        }else if(yellowHexButton.isSelected){
            _ = checkList!.updateValue(2, forKey: page)
            print(self.checkList![page]! as Any)
             page += 1
        }else if(redHexButton.isSelected){
            _ = checkList!.updateValue(3, forKey: page)
            print(self.checkList![page]! as Any)
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
        if(identifier != "Inspection15Segue"){
         
            self.performSegue(withIdentifier:identifier, sender: self)
        }else{
            
      
            let sendData = sendtoDB()
            sendData.exportData(selectedCar: self.selectedCar, checkList:
            self.checkList!,commentsList: self.commentsList!)
            //TODO add code for removing table row cell        }
    }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if segue.destination is InspectionViewController{


            // Get reference to the destination view controller
            let inspectionVC = segue.destination as? InspectionViewController
            // Set the property to the selected location so when the view for
            // detail view controller loads, it can access that property to get the feeditem object
            inspectionVC?.selectedCar = self.selectedCar
            inspectionVC?.checkList = self.checkList
            inspectionVC?.commentsList = self.commentsList

 }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Initialize the color buttons on the page. Check if one has already been selected
        //STILL NEED TO ADD DELEGATE METHOD
        greenHexButton.setImage(UIImage(systemName:"hexagon"), for: .normal)
        greenHexButton.setImage(UIImage(systemName:"hexagon.fill"), for: .selected)
        greenHexButton.addTarget(self, action: #selector(getter: self.greenHexButton), for: UIControl.Event.touchUpInside)
        if(checkList![page]! == 1){
            greenHexButton.isSelected = true
        }
        
        
        yellowHexButton.setImage(UIImage(systemName:"hexagon"), for: .normal)
        yellowHexButton.setImage(UIImage(systemName:"hexagon.fill"), for: .selected)
        yellowHexButton.addTarget(self, action: #selector(getter: self.yellowHexButton), for: UIControl.Event.touchUpInside)
        if(checkList![page]! == 2){
            print("bitchass")
            yellowHexButton.isSelected = true
        }
        
        
        redHexButton.setImage(UIImage(systemName:"hexagon"), for: .normal)
        redHexButton.setImage(UIImage(systemName:"hexagon.fill"), for: .selected)
        redHexButton.addTarget(self, action: #selector(getter: self.redHexButton), for: UIControl.Event.touchUpInside)
        if(checkList![page]! == 3){
            redHexButton.isSelected = true
        }
        
        //continueButton.layer.cornerRadius = 4
        
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        if(page != 1){
           
            page -= 1
            
            
        }
    }
   
    
    
}
    
    

