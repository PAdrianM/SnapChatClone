//
//  FeedViewController.swift
//  SNPClone
//
//  Created by Andrea Hernandez on 1/17/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        
    
    let fireStoreDatabase = Firestore.firestore()
    var snapArray = [SnapStuct]()
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        getSnapsFromFirebase()
        getUserInfo()
    }
    
    func getSnapsFromFirebase(){
        fireStoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                self.makeAlert(titel: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if difference >= 24 {
                                            //Delete
                                            self.fireStoreDatabase.collection("Snaps").document(documentId).delete { error in
                                                
                                            }
                                        }
                                        //TIMELEFT -> SNAPVC
                                    }
                                    
                                    let snap = SnapStuct(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                    
                                }
                            }
                        }
                    }
                    
                    self.feedTableView.reloadData()
                }
            }
        }
    }
    
    func getUserInfo() {
        
        fireStoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            
            if error != nil {
                self.makeAlert(titel: "Error", message: error?.localizedDescription ?? "Error")
                
            } else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        
                        if let username = document.get("username") as? String {
                            
                            UserSinglenton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSinglenton.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
    }
    func makeAlert(titel: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCellTableViewCell
        cell.feedUserLabel.text = snapArray[indexPath.row].username
        cell.feedImageView.sd_setImage(with: URL(string: snapArray[indexPath.row].imageUrlArray[0]))
        return cell
    }

}
