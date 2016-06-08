//
//  ViewController.swift
//  BeaconDetector
//
//  Created by Ashish on 08/06/16.
//  Copyright © 2016 Laxman. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController    {
    
    var locationManager: CLLocationManager!
    var lastProximity: CLProximity?
    @IBOutlet weak var tableView: UITableView!
    var beacons: [CLBeacon]?
    
    //MARK:- Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beacon Details"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- IBACtion Methods
    
    @IBAction func refreshButtonAction(sender: AnyObject) {
        self.tableView.reloadData()
    }
}
    



//MARK:- UITableViewDataSource Methods

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if(beacons != nil) {
            return beacons!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : BecaonDetailTableViewCell = self.tableView!.dequeueReusableCellWithIdentifier("BecaonDetailTableViewCell", forIndexPath: indexPath) as! BecaonDetailTableViewCell
        let beacon:CLBeacon = beacons![indexPath.row]
        var proximityLabel:String! = ""
        
        switch beacon.proximity {
        case CLProximity.Far:
            proximityLabel = "Far"
        case CLProximity.Near:
            proximityLabel = "Near"
        case CLProximity.Immediate:
            proximityLabel = "Immediate"
        case CLProximity.Unknown:
            proximityLabel = "Unknown"
        }
        cell.beaconProximatyLabel.text = proximityLabel
        cell.beaconMajorLabel.text =  "\(beacon.major.integerValue)"
        cell.beaconMinorLabel.text = "\(beacon.minor.integerValue)"
        cell.beaconUUIDLabel.text = beacon.proximityUUID.UUIDString
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}





