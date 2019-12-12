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

   
    
    @IBAction func metricSwitch(_ sender: UISwitch) {
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
                  height.placeholder = "Height(m)"
                  weight.placeholder = "Weight(kg)"
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

    }

    @IBAction func Done(_ sender: UIButton) {
         if (name.text == ""){
                       var alertController = UIAlertController(title: "Error", message:
                           "Enter heading" , preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                       self.present(alertController, animated: true, completion: nil)
                       return
                   }
                   if(age.text == ""){
                       var alertController = UIAlertController(title: "Error", message:
                           "Enter des" , preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                       self.present(alertController, animated: true, completion: nil)
                       return
                   }
        if(gender.text == ""){
            var alertController = UIAlertController(title: "Error", message:
                "Enter des" , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if(height.text == ""){
            var alertController = UIAlertController(title: "Error", message:
                "Enter des" , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        if(weight.text == ""){
            var alertController = UIAlertController(title: "Error", message:
                "Enter des" , preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            return
        }
                   
            
            

                   
            
                   let docId = db?.collection("data").document().documentID
            
        let parameters = ["name":name.text!,"age":age.text!,"gender": gender.text,"height":height.text,"weight":weight.text,"Result BMI":result.text,"docId":docId!,"completed":false] as [String : Any]
            
                   db?.collection("data").document(docId!).setData(parameters as [String : Any]){
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
        
        if weight.text != nil && height.text != nil, var weight = Double(weight.text!), var height = Double(height.text!) {
                   self.view.endEditing(true)
                   //Calculating BMI using metric, so convert to metric first
                   if !metricSwitch.isOn {
                       (weight) *= 0.453592;
                       (height) *= 0.0254;
                   }
                   let BMI: Double = weight / (height * height)
                   let shortBMI = String(format: "%.2f", BMI)
                   var resultText = "Your BMI is \(shortBMI): "
                   var descriptor : String?
                   if(BMI < 16.0) { descriptor = "Severe Thinessss" }
                   else if(BMI < 16.99) { descriptor = "Moderately Thin" }
                   else if(BMI < 18.55) { descriptor = "Mild Thiness" }
                   else if(BMI < 24.99) { descriptor = "Normal" }
                   else if(BMI < 29.99) { descriptor = "Overweight" }
                   else if(BMI < 34.99) { descriptor = "Obese class 1" }
                   else if(BMI < 39.99) { descriptor = " Obese class 2" }
                   else { descriptor = " Obese class 3" }
                   resultText += descriptor!
                   print(resultText)
                   result.text = resultText
                   result.isHidden = false
                   lastCalculationType = 0
               }
               else {
                   result.text = "Please fill out your height and weight."
                   result.isHidden = false
                   lastCalculationType = 0
               }
        
        
        
    }
}

