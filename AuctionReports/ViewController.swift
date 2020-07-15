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
    var selectedCar : UncheckedCarsModel = UncheckedCarsModel()
    let homeModel = HomeModel()
    @IBOutlet weak var ListTableView: UITableView!
    var selectedRow: IndexPath = IndexPath()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //Set delegates and initialize home model
        
        homeModel.delegate = self
        homeModel.downloadItems()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
         self.navigationController?.viewControllers = [self]
//        homeModel.delegate = self
        self.ListTableView.delegate = self
        self.ListTableView.dataSource = self
//      homeModel.getDownloadedItems()
        
        
    }
    
    
    func itemsDownloaded(items: NSMutableArray) {
        
        feedItems = items
        self.ListTableView.reloadData()
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
       // myCell.layer.cornerRadius = 8
        
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
            detailVC?.carsTable = self.presentingViewController as? ViewController
            detailVC?.selectedRow = selectedRow
        

    }

    }
    
    //unwinder function that is called by the unwindToCars Segue
    @IBAction func unwinder( _ seg: UIStoryboardSegue) {
        
        //First remove all viewControllers that were created from the last car inspection
//        self.navigationController?.viewControllers = [self]
        
        //Remove the inspected car from the feeditems NSArray and from the UItableView
        print("removing row at: ", selectedRow.row)
        feedItems.removeObject(at: selectedRow.row)
        
        if(feedItems.count == 0){
            
            //TODO: make popup or display something when the table is empty
        }
        
        ListTableView.deleteRows(at: [selectedRow], with: .fade)
        
    }

}


