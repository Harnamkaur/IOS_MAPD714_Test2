//
//  BMITrackerViewController.swift
//  IOS_MAPD714_Test2
//
//  Created by Harnam kaur on 11/12/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class BMITrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
     let cellSpacingHeight: CGFloat = 5
   var dict = [String:AnyObject]()
    @IBOutlet weak var tableView: UITableView!
      var db:Firestore?
    
    var dictionary = [[String:AnyObject]]()
        var inde = [String:AnyObject]()
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dictionary.count
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = (tableView.dequeueReusableCell(withIdentifier: "cell")! as? cell)!
            inde = dictionary[indexPath.row]
            cell.backgroundColor = UIColor.white
                 cell.layer.borderColor = UIColor.black.cgColor
                 cell.layer.borderWidth = 3
                 cell.layer.cornerRadius = 8
                 cell.clipsToBounds = true
            cell.nameshow.text = inde["name"] as? String
            cell.heightshow.text = inde["height"] as! String
            cell.weightshow.text = inde["weight"] as? String
            cell.bmishow.text = inde["Result BMI"] as? String
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        

        override func viewDidLoad() {
            super.viewDidLoad()
              db = Firestore.firestore()
            retrievedata()

            
        }
        
        func retrievedata(){
            var db = Firestore.firestore()
            db.collection("data").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                         self.dictionary.append(document.data() as [String : AnyObject])
                    }
                    self.tableView.reloadData()
                }
            }

            
            
        }

    @IBAction func deleteall(_ sender: UIButton) {
        
        db?.collection("data").document("User Profile").delete() { err in
                   if let err = err {
                       print("Error removing document: \(err)")
                   } else {
                       print("Document successfully removed!")
                   }
               }
}
}
