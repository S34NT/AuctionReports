//
//  PrimaryTabController.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 7/16/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation
import UIKit

class PrimaryTabController : UITabBarController, UITabBarControllerDelegate{
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.delegate = self
       
    }
    
    
    
   func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController){
   
    //If the selected View Controller is the list of uninspected cars, set firstPass property back to true
    //(without this setting, ViewController would continue to remove at the last used index when navigating to it)
    if(viewController == tabBarController.viewControllers?[1]){
        let inspectionNav = tabBarController.viewControllers![1] as! UINavigationController
        let carsTable = inspectionNav.topViewController as! ViewController
        carsTable.firstPass = true
        
    }
    
    
}


}
