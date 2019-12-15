//
//  ViewController.swift
//  IOS_MAPD714_Test2
//
//  Created by Harnam kaur on 11/12/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
//This file contain BMI calculation function and then it will stored to the firestore with the sepcific description

import UIKit
import FirebaseFirestore
import Firebase

class ViewController: UIViewController {

    

    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
  
    @IBOutlet weak var metricSwitch: UISwitch!
    var db:Firestore?
      var lastCalculationType: Int?

    
    var weightC:Double?
    var heightC:Double?
    
    
    @IBAction func calculate(_ sender: UIButton) {
        
        
         var Name = name.text!
                var Age = age.text!
                var Gender = gender.text!
                var Weight = weight.text!
                var Height = height.text!
                
                var db = Firestore.firestore()
        if (weight.text == ""){
                              var alertController = UIAlertController(title: "Error", message:
                                  "Enter Weight" , preferredStyle: .alert)
                              alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                              self.present(alertController, animated: true, completion: nil)
                              return
                          }
                          if(height.text == ""){
                              var alertController = UIAlertController(title: "Error", message:
                                  "Enter Height" , preferredStyle: .alert)
                              alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                              self.present(alertController, animated: true, completion: nil)
                              return
                          }
      
                if(metricSwitch.isOn){
                    
                    
                    var  data =  [
                        "name": Name,
                        "age": Age,
                        "gender": Gender,
                        "weight" : Weight+"pd",
                        "height" : Height+"in"]
                    
                    db.collection("BMI").document("data").setData(data) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            var wei = Double(Weight)
                            var hei = Double(Height)
                            var BMI = Double(wei!*703/(hei!*hei!))
                            let date = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd.MM.yyyy"
                            let result = formatter.string(from: date)
                            var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                            
                                  var descriptor : String?
                                  //
                                         if BMI < 16 {
                                             print("less than 16")
                                             descriptor = "Severe Thinessss"
                                         }
                                         else if BMI == 16 || BMI == 17
                                         {
                                          descriptor = "Moderately Thin"

                                         }
                                         else if BMI == 17 || BMI == 18
                                         {
                                          
                                           descriptor = "Mild Thiness"

                                         }
                                         
                                         
                                         else if BMI == 18 || BMI == 25
                                         {
                                               descriptor = "Normal"

                                         }
                                         
                                         else if BMI == 25 || BMI == 30
                                         {
                                             descriptor = "Overweight"

                                         }
                                         
                                         else if BMI == 30 || BMI == 35
                                         {
                                                      descriptor = "Obese class 1"

                                         }
                                         
                                         else if BMI == 35 || BMI == 40
                                         
                                         {
                                            descriptor = " Obese class 2"

                                          
                                         }
                                         else if BMI>40{
                                          
                                            descriptor = " Obese class 3"
//
                                         }
                            db.collection("entry").document(timestamp).setData([
                                "name" :Name,
                                "date": result,
                                "weight" : Weight+"pd",
                                "height" : Height+"in",
                                "bmi" : ""+String (format: "%.\(3)f",BMI)+" pd/in2",
                                "timestamp" : timestamp,
                                "Condition": descriptor
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                    
                                }
                                    
                                
                                
                                
                                
                                
                                else{
                                    
                                    let resulttext = result
                                    
                                    
                                    var alertController = UIAlertController(title: "BMI", message:
                                        "BMI is "+String (format: "%.\(3)f",BMI)+" pd/in2" as! String, preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: {
                                        (action) in self.performSegue(withIdentifier: "table", sender: nil)
                                    }))
                                    self.present(alertController, animated: true, completion: nil)

                                }
                                
                                
                                
                            }
                        }
                    }
                }
                
                else{
                    var  data =  [
                        "name": Name,
                        "age": Age,
                        "gender": Gender,
                        "weight" : Weight+"kg",
                        "height" : Height+"m",
                        "Condition ": description]
                    
                    db.collection("BMI").document("data").setData(data) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            var wei = Double(Weight)
                            var hei = Double(Height)
                            var BMI = Double(wei!/(hei!*hei!))
                            let date = Date()
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd.MM.yyyy"
                            let result = formatter.string(from: date)
                            var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                             var descriptor : String?
                                                              //
                                                                     if BMI < 16 {
                                                                         print("less than 16")
                                                                         descriptor = "Severe Thinessss"
                                                               //
                                                                     }
                                                                     else if BMI == 16 || BMI == 17
                                                                     {
                                                                      descriptor = "Moderately Thin"

                                                                     }
                                                                     else if BMI == 17 || BMI == 18
                                                                     {
                                                                      
                                                                       descriptor = "Mild Thiness"

                                                                     }
                                                                     
                                                                     
                                                                     else if BMI == 18 || BMI == 25
                                                                     {
                                                                           descriptor = "Normal"

                                                                     }
                                                                     
                                                                     else if BMI == 25 || BMI == 30
                                                                     {
                                                                         descriptor = "Overweight"

                                                                     }
                                                                     
                                                                     else if BMI == 30 || BMI == 35
                                                                     {
                                                                                  descriptor = "Obese class 1"

                                                                     }
                                                                     
                                                                     else if BMI == 35 || BMI == 40
                                                                     
                                                                     {
                                                                        descriptor = " Obese class 2"

                                                                      
                                                                     }
                                                                     else if BMI>40{
                                                                      
                                                                        descriptor = " Obese class 3"
                            //
                                                                     }
                            db.collection("entry").document(timestamp).setData([
                                "name": Name,

                                "date": result,
                                "weight" : Weight+"kg",
                                "height" : Height+"m",
                                "bmi" : ""+String (format: "%.\(3)f",BMI)+" kg/m2",
                                "timestamp" : timestamp,
                                "Condition" :descriptor
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                    
                                }else{
                                    var alertController = UIAlertController(title: "BMI", message:
                                        "BMI is "+String (format: "%.\(3)f",BMI)+" kg/m2" as! String, preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: {
                                        (action) in self.performSegue(withIdentifier: "table", sender: nil)
                                    }))
                                    self.present(alertController, animated: true, completion: nil)
                                    
                                }
                            }
                        }
                    }
                }
            }
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
                var db = Firestore.firestore()
                
                let docRef = db.collection("BMI").document("data")
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BMITracker") as! BMITrackerViewController
                        self.present(mainVC, animated: true, completion: nil)
                    } else {
                        print("Document does not exist")
                    }
                }
            }
        }


    
    
    
    
