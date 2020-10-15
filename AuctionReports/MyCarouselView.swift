//
//  MyCarouselView.swift
//  AuctionReports
//
//  Created by Sean Phillip Thompson on 8/8/20.
//  Copyright © 2020 Sean Phillip Thompson. All rights reserved.
//
import iCarousel
import Foundation
import UIKit
class MyCarouselView: UIViewController, iCarouselDataSource, URLSessionDelegate {
    
    let auctionNamesList = ["West Michigan", "Kalamazoo", "Grand Rapids"]
    
    enum NetworkError: Error {
        case url
        case server
        }
    func makeAPICall(runList:String) -> String? {

        var string = ""
                let url = NSURL(string:"https://www.wlgenerator.tech/generate.php")
        var request = URLRequest(url: url! as URL)
                
        request.httpMethod = "POST"
        let postString = runList
        request.httpBody = postString.data(using: String.Encoding.utf8)
                let semaphore = DispatchSemaphore(value: 0)
        
                let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        
        let task = defaultSession.dataTask(with: request) { (data, response, error) in
        
                    if error != nil {
                        print("Failed get a response")
                    }else {
        
                        if let data = data {
                            string = String(data: data, encoding: String.Encoding.utf8)!
                            
                        }
        
                    }
                    semaphore.signal()
                }
                task.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return string
        
    }
    
    let myCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .rotary
        return view
    }()
    
    //asynchronously execute the list generating python script on the server and prints the status
    @IBAction func generateList(sender: UIButton){
        //var theAuction = auctionNamesList[sender.tag]
        var theAuction = auctionNamesList[myCarousel.currentItemIndex]
        print(theAuction)
        EXIT_SUCCESS
        DispatchQueue.global(qos: .utility).async {
            let result = self.makeAPICall(runList: theAuction)
         
         DispatchQueue.main.async {

            print(result!)
            
            }
            
        }
        
    }
    
    //this function sets the number of items in the carousel
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    //sets the width of the items in carousel
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return myCarousel.bounds.width //Whatever the size you want to set
    }
    

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView{
        
        let view = UIView(frame: CGRect(x:0, y:0, width: self.view.frame.size.width/1.4, height:200))
        
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        
        //Create the blur effect view
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
       
        blurEffectView.frame = view.bounds
        blurEffectView.layer.cornerRadius = view.layer.cornerRadius
        blurEffectView.clipsToBounds = true
        
        //Create the labels for the carousel items dynamically using the auctionNamesList array
        let auctionName = UILabel(frame: view.bounds)
        auctionName.textAlignment = .center
        auctionName.text = auctionNamesList[index]
        auctionName.tintColor = .white
        auctionName.textColor = .white

        //Create the download button
        let downloadButton = UIButton(frame: CGRect(x:85, y:520, width: 200, height:50))
        downloadButton.setTitle("Download Runlist", for: .normal)
        downloadButton.titleLabel?.textAlignment = .center
        downloadButton.backgroundColor = .darkGray
        downloadButton.layer.cornerRadius = 8
        downloadButton.layer.borderWidth = 1
        downloadButton.clipsToBounds = false
       
        downloadButton.setTitleColor(UIColor.black, for: .normal)
        //Add functionality for button by connecting it to the generateList function
        downloadButton.addTarget(self, action:  #selector(generateList), for: .touchUpInside)
        downloadButton.tag = index
        
        //Add all of the subviews on to the main view
        view.addSubview(blurEffectView)
        view.addSubview(auctionName)
        //view.addSubview(downloadButton)
        self.view.superview?.addSubview(downloadButton)
        
        return view
    }

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myCarousel)
        myCarousel.dataSource = self
        
        
        myCarousel.frame = CGRect(x:0, y:350, width: self.view.frame.size.width, height: 200)
        
        
    }
    
}
