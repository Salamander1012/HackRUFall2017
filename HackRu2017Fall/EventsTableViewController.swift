//
//  EventsTableViewController.swift
//  HackRu2017Fall
//
//  Created by Salman Fakhri on 10/14/17.
//  Copyright © 2017 Salman Fakhri. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore
import SwiftyJSON
import CoreLocation

class EventsTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var ref: DatabaseReference!
    
    /*
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    var locationManager: CLLocationManager!
    
    var eventNames: [String] = []
    var eventLocations: [String] = []
    var long: Double = 1.0
    var lat: Double = 1.0
    
    var dataPushLoopCount = 2
    var locCount = 1
    var pushData = false
    var userNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewInternal()
        tableView.rowHeight = 130
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            // ...
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        long = locValue.longitude
        lat = locValue.latitude
        
        ref = Database.database().reference()
        dataPushLoopCount+=1
        if dataPushLoopCount % 2 == 0 && pushData == true {
            ref.child("Graphs").child("Heatmap").child("features").child("\(locCount)").setValue(["geometry": ["coordinates": ["0": long, "1":lat], "type": "Point"], "properties": ["time": 235123], "type": "Feature"])
            locCount += 1
        }
        
        
        
        print("Current Locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func loadViewInternal() {
        ref = Database.database().reference()
        
        ref.child("Events").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            for item in (snapshot.children) {
                for thing in (item as! DataSnapshot).children {
                    if (thing as! DataSnapshot).key == "location" {
                        self.eventLocations.append((thing as! DataSnapshot).value as! String)
                        //print((thing as! DataSnapshot).value)
                        
                    }
                    if (thing as! DataSnapshot).key == "name" {
                        self.eventNames.append((thing as! DataSnapshot).value as! String)
                        //print((thing as! DataSnapshot).value)
                        
                    }
                    
                }
            }
            //print(self.eventLocations)
            print("\(self.eventNames.count) event count")
            self.tableView.reloadData()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("\(self.eventNames.count) event count haha")
        return eventNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! EventTableViewCell
        
        cell.setUpCell(eventName: eventNames[indexPath.row], eventLocation: eventLocations[indexPath.row])
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("saving location data")
        
        let cell = tableView.cellForRow(at: indexPath) as! EventTableViewCell
        cell.changeCheckInStatus()
        tableView.reloadData()
        pushData = !pushData
       
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
