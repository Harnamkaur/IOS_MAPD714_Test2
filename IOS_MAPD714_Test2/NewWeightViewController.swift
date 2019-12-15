//
//  NewWeightViewController.swift
//  IOS_MAPD714_Test2
//
//  Created by Harnam kaur on 11/12/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
// In this file hieght is fetched form the firestore which we described first time  and with new weight we perform the bmi calculation operation

import UIKit
import FirebaseFirestore
import Firebase

class NewWeightViewController: UIViewController {
  //  var db:Firestore?
    
    var inde = [String:AnyObject]()

    @IBOutlet weak var InfoLabel: UILabel!
   
    
    @IBOutlet weak var weightNew: UITextField!
    
    @IBOutlet weak var heightNew: UILabel!
    
    @IBOutlet weak var newBMI: UILabel!
   
    
    
    
    
    
    
    @IBAction func calculateagain(_ sender: Any) {
        
        
        //if the unit is not metric then this function will be pefrormed
        //and the data with new bmi is loaded to firestore
         var weigh = Double(weightNew.text!)
                var heigh = heightNew.text!
                if((heigh.contains("m"))){
                    heigh.removeLast()
                    print(heigh)
                    var hei = Double(heigh)
                   // var BMI = Double(weigh!/(hei!*hei!))
                     var BMI = Double(weigh!*703/(hei!*hei!))
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM.yyyy"
                    let result = formatter.string(from: date)
                    var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                     var descriptor : String?
                                                      // descritopn acording their bmi
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
                    var db = Firestore.firestore()
                    db.collection("entry").document(timestamp).setData([
                        "date": result,
                        "weight" : String(weigh!)+"kg",
                        "height" : heightNew.text,
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
                                (action) in self.performSegue(withIdentifier: "main", sender: nil)
                            }))
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                        
                        
                    }
                }
                    
                    //if the unit is  metric then this function will be pefrormed
                           //and the data with new bmi is loaded to firestore
                else{
                    heigh.removeLast()
                    heigh.removeLast()
                    print(heigh)
                    var hei = Double(heigh)
                     var BMI = Double(weigh!/(hei!*hei!))
                  //  var BMI = Double(weigh!*703/(hei!*hei!))
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM.yyyy"
                    let result = formatter.string(from: date)
                    var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                     var descriptor : String?
                                                      // descritopn acording their bmi
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
                    
                    //data is loaded to firestore with new bmi
                    var db = Firestore.firestore()
                    db.collection("entry").document(timestamp).setData([
                        "date": result,
                        "weight" : String(weigh!)+"pd",
                        "height" : heightNew.text,
                        "bmi" : ""+String (format: "%.\(3)f",BMI)+" pd/in2",
                        "timestamp" : timestamp,
                        "Condition":descriptor
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                            
                        }else{
                            var alertController = UIAlertController(title: "BMI", message:
                                "BMI is "+String (format: "%.\(3)f",BMI)+" pd/in2" as! String, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: {
                                (action) in self.performSegue(withIdentifier: "main", sender: nil)
                            }))
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                
                
                
                
                
                
                
            }
            override func viewDidLoad() {
                super.viewDidLoad()
                var db = Firestore.firestore()
                
                db.collection("BMI").document("data").getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.heightNew.text = document.data()!["height"] as! String
                        var detail = self.heightNew.text
                        if(detail!.contains("m")){
                            self.InfoLabel.text = "Enter weight in kgs"
                        }
                        else{
                            self.InfoLabel.text = "Enter weight in pounds"
                        }
                    } else {
                        print("Document does not exist")
                    }
                }
                
                
                
            }
            
            
            
        }
