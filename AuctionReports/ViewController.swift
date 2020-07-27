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
    var feedItems: NSMutableArray = NSMutableArray()
    var firstPass : Bool
    var selectedCar : UncheckedCarsModel = UncheckedCarsModel()
    let homeModel: HomeModel?
    @IBOutlet weak var ListTableView: UITableView!
    var selectedRow: IndexPath = IndexPath()
    
    required init?(coder aDecoder: NSCoder) {
        self.firstPass = true
        self.homeModel = HomeModel()
        print("in init method")
        super.init(coder: aDecoder)
        
        
        
        //Set delegate
        homeModel?.delegate = self
        homeModel?.downloadItems()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
//        self.navigationController?.viewControllers = [self]

        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
        self.ListTableView.reloadData()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //Once the view appears, check if it is the first pass or not,
        //if it is, remove the car that was just inspected from the list of cars
        if(self.firstPass == false){
        
            print("removing row at: ", selectedRow.row)
            feedItems.removeObject(at: selectedRow.row)
            ListTableView.deleteRows(at: [selectedRow], with: .fade)
            if(feedItems.count == 0){
                
                //TODO: make popup or display something when the table is empty
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func itemsDownloaded(items: NSMutableArray) {
        
        feedItems = items
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Retrieve cell
        let cellIdentifier: String = "basicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the cars to be shown
        let item: UncheckedCarsModel = feedItems[indexPath.row] as! UncheckedCarsModel
        // Get references to labels of cell
        
        myCell.textLabel!.text = "\(item.year!) \(item.make!) \(item.model!)"
        
        return myCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        selectedRow = indexPath
        
        
        selectedCar = feedItems[selectedRow.row] as! UncheckedCarsModel
      
        
        print("\(String(describing: selectedCar.make))")

        //Perform a segue to the DetailViewController for the selected car
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.destination is DetailViewController{
            
            
            print("\(String(describing: selectedCar.model))") // Get reference to the destination view controller
            let detailVC  = segue.destination as? DetailViewController
            
            // Set the property to the selected location so when the view for
            // detail view controller loads, it can access that property to get the feeditem obj
            detailVC?.selectedCar = selectedCar
            detailVC?.selectedRow = selectedRow
        

    }

    }
    
    //unwinder function that is called by the unwindToCars Segue
    @IBAction func unwinder( _ seg: UIStoryboardSegue) {
        
        self.firstPass = false
        
        //First remove all viewControllers that were created from the last car inspection
        self.navigationController?.viewControllers = [self]
        
    }

}


