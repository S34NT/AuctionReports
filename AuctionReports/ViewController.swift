//
//  ViewController.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 6/27/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol  {
    
    
    //Properties
    let cellSpacingHeight: CGFloat = 5
    var feedItems: NSMutableArray = NSMutableArray()
    var firstPass : Bool
    var clearTable : Bool
    var selectedCar : UncheckedCarsModel = UncheckedCarsModel()
    let homeModel: HomeModel?
    @IBOutlet weak var ListTableView: UITableView!
    var selectedRow: IndexPath = IndexPath()
    
    required init?(coder aDecoder: NSCoder) {
        self.firstPass = true
        self.clearTable = false
        self.homeModel = HomeModel()
        print("in init method")
        super.init(coder: aDecoder)

        
        //Set delegate
        homeModel?.delegate = self
        homeModel?.downloadItems()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Initialize the TableView
        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
        self.ListTableView.backgroundColor = .yellow
        self.ListTableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Once the view appears, check if it is the first pass or not,
        //if it is, remove the car that was just inspected from the list of cars
        if(self.firstPass == false){
        
            print("removing row at: ", selectedRow.section)
            feedItems.removeObject(at: selectedRow.section)
            ListTableView.deleteSections([selectedRow.section], with: .fade)
            if(feedItems.count == 0){
                
                //TODO: make popup or display something when the table is empty
            }
            
            
        }
    }
    
    //Remove anything that can be recreated
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //This function is called from HomeModel, and passes the
    //data that is returned from the server
    func itemsDownloaded(items: NSMutableArray) {
        feedItems = items
    }
    
    //Set the numbe of sections equal to the number of cars
    //that were pulled from the server
    func numberOfSections(in tableView: UITableView) -> Int{
        
        if clearTable == true{
            return 0
        }else{
            return self.feedItems.count
        }
        
    }
    
    //set number of rows for a section to 1
    func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    
    //set the Header color to clear
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    //This function defines the attributes of the reusable cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //After all of the prototype cells have been generated for each of the cars,
        //create the delete list cell/button
        if(indexPath.section == numberOfSections(in: tableView) - 1){
    
            let cellIdentifier: String = "listDelete"
            let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
            myCell.textLabel!.text = "Delete List"
            myCell.textLabel!.textAlignment = .center
            myCell.textLabel!.textColor = .white
            myCell.backgroundColor = .red
            myCell.layer.cornerRadius = 8
            myCell.layer.borderWidth = 1
            
            return myCell
            
        }else{
            
            // Retrieve cell
            let cellIdentifier: String = "basicCell"
            let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
            
            // Get the cars to be shown
            let item: UncheckedCarsModel = feedItems[indexPath.section] as! UncheckedCarsModel
            
            // Get references to labels of cell
            myCell.textLabel!.text = "\(item.year!) \(item.make!) \(item.model!)"
            
            myCell.textLabel!.textAlignment = .center
            myCell.backgroundColor = .white
            myCell.layer.cornerRadius = 8
            myCell.layer.borderWidth = 1
            
            return myCell
            
        }
        
    }
    
    //Set the height of the header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    //This function controls what happens when users interact with the UITableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if(indexPath.section == feedItems.count - 1){
            homeModel?.deleteListItems()
            feedItems.removeAllObjects()
            clearTable = true
            self.viewDidLoad()
            print("list should be gone")
        }else{
            //When user selects a row, assign the value to selectedCar (UncheckedCarsModel Object)
              selectedRow = indexPath
              selectedCar = feedItems[selectedRow.section] as! UncheckedCarsModel
            
              print("\(String(describing: selectedCar.make))")

              //Perform a segue to the DetailViewController for the selected car
              self.performSegue(withIdentifier: "detailSegue", sender: self)
        }
        
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.destination is DetailViewController{
            
            
            // Get reference to the destination view controller
            let detailVC  = segue.destination as? DetailViewController
            
            // Set the property to the selected location so when the view for
            // DetailViewController loads, it can access that property to get the feeditem obj
            detailVC?.selectedCar = selectedCar
            detailVC?.selectedRow = selectedRow
        }

    }
    
    //unwinder function that is called by the unwindToCars Segue
    //(Called from the InspectionViewController)
    @IBAction func unwinder( _ seg: UIStoryboardSegue) {
        
        //toggle firstpass so the car will be removed when ViewDidAppear is called
        self.firstPass = false
        
        //First remove all viewControllers that were created from the last car inspection
        self.navigationController?.viewControllers = [self]
        
    }

}


