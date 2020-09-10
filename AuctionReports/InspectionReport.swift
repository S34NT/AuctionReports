//
//  InspectionReport.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 7/17/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//

import Foundation
import UIKit


class InspectionReport: UITableViewController, ReportModelProtocol{
    
   
    
    @IBOutlet var ReportTableView: UITableView!
    
    let cellSpacingHeight: CGFloat = 5
    var reportItems: NSMutableArray = NSMutableArray()
    var inspectedCar : CheckedCarsModel = CheckedCarsModel()
    var reportModel : ReportModel?

    
    required init?(coder aDecoder: NSCoder) {
        
        self.reportModel = ReportModel()
        print("in init method")
        super.init(coder: aDecoder)
        
        //Set delegate
        reportModel?.delegate = self
        reportModel?.downloadItems()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("report items = \(self.reportItems.count)")
        return self.reportItems.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("setting the cells")
        // Retrieve cell
               let cellIdentifier: String = "basicCell2"
               let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
               // Get the cars to be shown
               let item: CheckedCarsModel = reportItems[indexPath.section] as! CheckedCarsModel
               // Get references to labels of cell
               
               myCell.textLabel!.text = "\(item.year!) \(item.make!) \(item.model!)"
               myCell.textLabel?.textAlignment = .center
               myCell.backgroundColor = .white
               myCell.layer.borderWidth = 1
             
               return myCell
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func itemsDownloaded(items: NSMutableArray) {
        
        reportItems = items
        print("report items was set")
        self.viewDidAppear(true)
        
 
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        inspectedCar = reportItems[indexPath.section] as! CheckedCarsModel
      
        
        print("\(String(describing: inspectedCar.make))")

        //Perform a segue to the inspectionDetailViewController for the selected car
        self.performSegue(withIdentifier: "inspectedDetailSegue", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.destination is InspectionDetailViewController{
            
            
            print("\(String(describing: inspectedCar.model))") // Get reference to the destination view controller
            let inspectedDetailVC  = segue.destination as? InspectionDetailViewController
            
           
            inspectedDetailVC?.inspectedCar = inspectedCar
    
        

    }

    }
    
    @IBAction func refreshTable(_ sender: Any) {
        
      
        (sender as AnyObject).beginRefreshing()
        
        let group = DispatchGroup()
        group.enter()
        self.reportItems.removeAllObjects()
        group.leave()
        
        DispatchQueue.main.async{
        self.reportModel?.downloadItems()
        }
            
        
            (sender as AnyObject).endRefreshing()
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.ReportTableView.reloadData()
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()

    }
    
    
    
}
