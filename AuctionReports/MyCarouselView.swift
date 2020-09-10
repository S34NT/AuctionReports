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
        var theAuction = auctionNamesList[sender.tag]
        
        DispatchQueue.global(qos: .utility).async {
            let result = self.makeAPICall(runList: theAuction)
         
         DispatchQueue.main.async {

            print(result!)
            
            }
            
        }
        
    }
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 3
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.myCarousel.reloadData()
        }, completion: nil)
    }
    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
        return myCarousel.bounds.width //Whatever the size you want to set
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView{
        
        let view = UIView(frame: CGRect(x:0, y:0, width: self.view.frame.size.width/1.4, height:300))
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10

        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
       
        //always fill the view
        blurEffectView.frame = view.bounds
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        
        
        
        
        let auctionName = UILabel(frame: view.bounds)
        auctionName.textAlignment = .center
        auctionName.text = auctionNamesList[index]
        auctionName.tintColor = .white
        auctionName.textColor = .white
        
        let downloadButton = UIButton(frame: CGRect(x:33.2, y:180, width: 200, height:50))
        downloadButton.setTitle("Download Runlist", for: .normal)
        downloadButton.titleLabel?.textAlignment = .center
        downloadButton.backgroundColor = .cyan
        downloadButton.layer.cornerRadius = 8
        downloadButton.layer.borderWidth = 1
        downloadButton.setTitleColor(UIColor.black, for: .normal)
        downloadButton.addTarget(self, action:  #selector(generateList), for: .touchUpInside)
        downloadButton.tag = index
        
        
        view.addSubview(blurEffectView)
        view.addSubview(auctionName)
        view.addSubview(downloadButton)
        
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
        
        
        myCarousel.frame = CGRect(x:0, y:200, width: self.view.frame.size.width, height: 400)
    }
    
}
