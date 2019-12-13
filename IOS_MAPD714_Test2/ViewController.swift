//
//  ViewController.swift
//  IOS_MAPD714_Test2
//
//  Created by Harnam kaur on 11/12/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ViewController: UIViewController {

    

    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var result: UITextField!
    @IBOutlet weak var metricSwitch: UISwitch!
    var db:Firestore?
      var lastCalculationType: Int?

    
    var weightC:Double?
    var heightC:Double?
    
    
   
    
    @IBAction func metricSwitch(_ sender: UISwitch) {
                        height.placeholder = "Height(m)"
                        weight.placeholder = "Weight(kg)"
        if sender.isOn {
                  //If text is already there, convert it to metric
                  if height.text != nil && !((height.text!).isEmpty) {
                      if let heightVal = Double(height.text!) {
                          height.text = String(format: "%.2f", heightVal * 0.0254)
                      }
                  }
                  if weight.text != nil && !((weight.text!).isEmpty) {
                      if let weightVal = Double(weight.text!) {
                          weight.text = String(format: "%.2f", weightVal * 0.453592)
                      }
                  }
                
//                  else if lastCalculationType == 0 && height.text != nil && !((height.text!).isEmpty) && weight.text != nil && !((weight.text!).isEmpty) {
//                      calculate(nil)
//                  }
                
              }
              else {
                  //If text is already there, convert it to imperial
                  if height.text != nil && !((height.text!).isEmpty) {
                      if let heightVal = Double(height.text!) {
                          height.text = String(format: "%.2f", heightVal / 0.0254)
                      }
                  }
                  if weight.text != nil && !((weight.text!).isEmpty) {
                      if let weightVal = Double(weight.text!) {
                          weight.text = String(format: "%.2f", weightVal / 0.453592)
                      }
                  }
                 
//                  else if lastCalculationType == 0 && height.text != nil && !((heightField.text!).isEmpty) && weightField.text != nil && !((weightField.text!).isEmpty) {
//                      calculateButton(nil)
//                  }
                  height.placeholder = "Height(in)"
                  weight.placeholder = "Weight(lbs)"
              }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        
//
        var db = Firestore.firestore()

        let docRef = db.collection("data").document("User Profile")

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

    @IBAction func Done(_ sender: UIButton) {
         if (name.text == ""){
                       var alertController = UIAlertController(title: "Error", message:
                           "Enter Name" , preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                       self.present(alertController, animated: true, completion: nil)
                       return
                   }
                   if(age.text == ""){
                       var alertController = UIAlertController(title: "Error", message:
                           "Enter age" , preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                       self.present(alertController, animated: true, completion: nil)
                       return
                   }
        if(gender.text == ""){
            var alertController = UIAlertController(title: "Error", message:
                "Enter gender" , preferredStyle: .alert)
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
        if(weight.text == ""){
            var alertController = UIAlertController(title: "Error", message:
                "Enter Weight" , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
                   
            
            

                   
            
//                   let docId = db?.collection("data").document("User Profile").documentID
            
        let parameters = ["name":name.text!,"age":age.text!,"gender": gender.text,"height":height.text,"weight":weight.text,"Result BMI":result.text,"completed":false] as [String : Any]
            
                   db?.collection("data").document("User Profile").setData(parameters as [String : Any]){
                       err in
                       if let error = err{
                           print(error.localizedDescription)
                         // self.indicator.stopAnimating()
                       }else{
                           print("document added successfully")
                          // self.indicator.stopAnimating()
                           let alert = UIAlertController(title: "Message", message: "Successfully added", preferredStyle: .alert)
                           let okay = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                             //  self.navigationController?.popViewController(animated: true)
                           })
                           alert.addAction(okay)
        //
                                               self.present(alert, animated: true, completion: nil)
                       }
            
                   }
        
        
        
        
       
        
        
    }
    @IBAction func reset(_ sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func calculate(_ sender: Any) {
        
//        if weight.text != nil && height.text != nil, var weight = Double(weight.text!), var height = Double(height.text!) {
//                   self.view.endEditing(true)
//                   //Calculating BMI using metric, so convert to metric first
//                   if !metricSwitch.isOn {
//                       (weight) *= 0.453592;
//                       (height) *= 0.0254;
//                   }
            
            
            weightC = Double(self.weight.text!)
            heightC = Double(self.height.text!)
        print("weight height is",weightC!,heightC!)
          
            let BMI  = (weightC!/(heightC!*heightC!))
            print("bmi is",BMI)
        
//                   let BMI = weightC / (heightC * heightC)
        
//                   let shortBMI = String(format: "%.2f", BMI)
//                   var resultText = "Your BMI is \(shortBMI): "
                  var descriptor : String?
//
       if BMI < 16 {
           print("less than 16")
           descriptor = "Severe Thinessss"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"
       }
       else if BMI == 16 || BMI == 17
       {
        descriptor = "Moderately Thin"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"

       }
       else if BMI == 17 || BMI == 18
       {
        
         descriptor = "Mild Thiness"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"

       }
       
       
       else if BMI == 18 || BMI == 25
       {
             descriptor = "Normal"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"

       }
       
       else if BMI == 25 || BMI == 30
       {
           descriptor = "Overweight"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"

       }
       
       else if BMI == 30 || BMI == 35
       {
                    descriptor = "Obese class 1"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"

       }
       
       else if BMI == 35 || BMI == 40
       
       {
          descriptor = " Obese class 2"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"

        
       }
       else if BMI>40{
        
          descriptor = " Obese class 3"
        self.result.text = "\(BMI)  \(String(describing: descriptor!))"

       }

//
        
             
//        
//        
//                   resultText += descriptor!
//                   print(resultText)
//                   result.text = resultText
//        
        
        
        
                   result.isHidden = false
                   lastCalculationType = 0
               
//            else if metricSwitch.isOn{
//             //If text is already there, convert it to imperial
//             if height.text != nil && !((height.text!).isEmpty) {
//                 if let heightVal = Double(height.text!) {
//                     height.text = String(format: "%.2f", heightVal / (0.0254))
//                 }
//             }
//             if weight.text != nil && !((weight.text!).isEmpty) {
//                 if let weightVal = Double(weight.text!) {
//                     weight.text = String(format: "%.2f", weightVal / 0.453592)
//                 }
//             }
        
            
//
//               else {
//                   result.text = "Please fill out your height and weight."
//                   result.isHidden = false
//                   lastCalculationType = 0
//               }
//
        
        
    }
}

