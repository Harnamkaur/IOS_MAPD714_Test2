//
//  NewWeightViewController.swift
//  IOS_MAPD714_Test2
//
//  Created by Harnam kaur on 11/12/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class NewWeightViewController: UIViewController {
  //  var db:Firestore?

    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var height: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    db = Firestore.firestore()


        // Do any additional setup after loading the view.
    }
    @IBAction func calculateagain(_ sender: Any) {
        
        
        
    }
//var docRef = db.collection("users").doc("ID");
//    
//   docRef.get().then(function(doc) {
//   if (doc.exists) {
//   //gives full object of user
//   console.log("Document data:", doc.data());
//   //gives specific field
//   var height = doc.get("height");
//   console.log(height);
//
//   } else {
//       // doc.data() will be undefined in this case
//       console.log("No such document!");
//   }
//   }).catch(function(error) {
//   console.log("Error getting document:", error);
//   });


}
