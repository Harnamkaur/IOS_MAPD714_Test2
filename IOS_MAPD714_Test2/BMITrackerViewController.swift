//
//  BMITrackerViewController.swift
//  IOS_MAPD714_Test2
// cell.backgroundColor = UIColor.white
               
//  Created by Harnam kaur on 11/12/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
// In this file all the results are fetched from the firestore and represented in table view format

import UIKit
import Firebase
import FirebaseFirestore

class BMITrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
     let cellSpacingHeight: CGFloat = 5

    @IBOutlet weak var tableView: UITableView!
     var dictionary = [[String:AnyObject]]()
          var inde = [String:AnyObject]()
          
          
    
   
    
    
    @IBAction func DeletAll(_ sender: UIButton) {
        var db = Firestore.firestore()

        db.collection("entries").document().delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
          
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return dictionary.count
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = (tableView.dequeueReusableCell(withIdentifier: "cell")! as? cell)!
            cell.layer.borderColor = UIColor.black.cgColor
                           cell.layer.borderWidth = 3
                           cell.layer.cornerRadius = 8
                           cell.clipsToBounds = true
              inde = dictionary[indexPath.row]
             //   cell.nameshow.text = inde["name"] as! String
              cell.weightshow.text = inde["weight"] as! String
              cell.heightshow.text = inde["date"] as! String
              cell.bmiShow.text = inde["bmi"] as? String
               cell.descriptor.text = inde["Condition"] as! String
            
              
              return cell
          }
          
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 180
          }
          
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              inde = dictionary[indexPath.row]
              
              var db = Firestore.firestore()
              db.collection("entry").document(String(inde["timestamp"] as! String)).delete() { err in
                  if let err = err {
                      print("Error removing document: \(err)")
                  } else {
                      
                  }
              }
              
              
              
          }
          
          
          override func viewDidLoad() {
              super.viewDidLoad()
              retrievedata()
              
              
          }
          
          func retrievedata(){
              var db = Firestore.firestore()
              db.collection("entry").addSnapshotListener { (querySnapshot, err) in
                  if let err = err {
                      print("Error getting documents: \(err)")
                  } else {
                      self.dictionary.removeAll()
                      for document in querySnapshot!.documents {
                          self.dictionary.append(document.data() as [String : AnyObject])
                      }
                      let count = self.dictionary.count
                      if(count == 0){
                          db.collection("BMI").document("data").delete() { err in
                              if let err = err {
                                  print("Error removing document: \(err)")
                              } else {
                                  self.performSegue(withIdentifier: "main", sender: nil)
                              }
                          }
                      }
                      print("a")
                      self.tableView.reloadData()
                  }
              }
              
              
              
          }
          
      }
          


