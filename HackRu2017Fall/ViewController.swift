//
//  ViewController.swift
//  HackRu2017Fall
//
//  Created by Salman Fakhri on 10/14/17.
//  Copyright © 2017 Salman Fakhri. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //var locationManager: CLLocationManager!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBAction func saveButton(_ sender: UIButton) {
        
        if !(nameField.text?.isEmpty)! && !(emailField.text?.isEmpty)! {
            UserDefaults.standard.set(true, forKey: "userExists")
            UserDefaults.standard.setValue(nameField.text!, forKey: "username")
            UserDefaults.standard.setValue(emailField.text!, forKey: "email")
            self.performSegue(withIdentifier: "goToTable", sender: sender)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        */
        // Do any additional setup after loading the view, typically from a nib.
        print(UserDefaults.standard.bool(forKey: "userExists"))
        print(UserDefaults.standard.string(forKey: "username"))
        if UserDefaults.standard.bool(forKey: "userExists") {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToTable", sender: nil)
            }
            
        }
        
    }
    /*
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
        
        
        print("Current Locations = \(locValue.latitude) \(locValue.longitude)")
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

