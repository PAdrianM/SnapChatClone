//
//  SettingsViewController.swift
//  SNPClone
//
//  Created by Andrea Hernandez on 1/17/24.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toSignVc", sender: nil)
            } catch {
                
        }
    }
}
