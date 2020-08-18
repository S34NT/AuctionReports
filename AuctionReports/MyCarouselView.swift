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
class MyCarouselView: UIViewController, iCarouselDataSource {
    
    let myCarousel: iCarousel = {
        let view = iCarousel()
        view.type = .rotary
        return view
    }()
    
   
    
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        
        let auctionNamesList = ["West Michigan", "Kalamazoo", "Grand Rapids"]
        let auctionName = UILabel(frame: view.bounds)
        auctionName.textAlignment = .center
        auctionName.text = auctionNamesList[index]
        
        let downloadButton = UIButton(frame: CGRect(x:33.2, y:180, width: 200, height:50))
        downloadButton.setTitle("Download Runlist", for: .normal)
        downloadButton.titleLabel?.textAlignment = .center
        downloadButton.backgroundColor = .cyan
        downloadButton.layer.cornerRadius = 8
        downloadButton.layer.borderWidth = 1
        downloadButton.setTitleColor(UIColor.black, for: .normal)
        
        
       
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
