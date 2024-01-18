//
//  ViewController.swift
//  SNPClone
//
//  Created by Andrea Hernandez on 1/16/24.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SingInVc: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if passwordText.text != "" && emailText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { result, error in
                if error != nil {
                    
                    self.makeAlert(titel: "Error", message: error?.localizedDescription ?? "Error")
                    
                } else {
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        } else {
            
            self.makeAlert(titel: "Error", message: "Ingrese Password e Email")
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if userNameText.text != "" && passwordText.text != "" && emailText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { auth, error in
                if error != nil {
                    self.makeAlert(titel: "Error", message: error?.localizedDescription ?? "Error verifique que ingreso bien los datos")
                } else {
                    
                    let firesTore = Firestore.firestore()
                    let userDictionary = ["email": self.emailText.text!, "username": self.userNameText.text!] as! [String : Any]
                    firesTore.collection("UserInfo").addDocument(data: userDictionary) { error in
                        if error != nil {
                            //
                        }
                    }
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            
            self.makeAlert(titel: "Error", message: "Verificar que esten llenos todos los campos")
        }
    }
    
    
    func makeAlert(titel: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

