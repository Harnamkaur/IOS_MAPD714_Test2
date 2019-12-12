//
//  BMITrackerViewController.swift
//  IOS_MAPD714_Test2
//
//  Created by Harnam kaur on 11/12/19.
//  Copyright © 2019 Harnam kaur. All rights reserved.
//

import UIKit
import FirebaseFirestore

class BMITrackerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
   
    @IBOutlet weak var tableView: UITableView!
    
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
           
           let index = dictionary[indexPath.row]
           print("index",index)
           
           
           return cell
       }
    
    var db: Firestore?
    var dictionary = [[String:AnyObject]]()
//    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()

        // Do any additional setup after loading the view.
    }
    
    func retrieveData(){
        self.dictionary.removeAll()
        db = Firestore.firestore()
        db?.collection("data").getDocuments(completion: { (snap, err) in

            for i in snap!.documents{
                self.dictionary.append(i.data() as [String : AnyObject])

            }
            print("dict is",self.dictionary)

//            self.tableView.reloadData()
        })
        


        
    }
    

     
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        return dictionary.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
