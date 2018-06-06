//
//  LoginViewController.swift
//  BiteTalkServer
//
//  Created by 신진욱 on 01/06/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    var loginCheckResult: Bool?
    var userRef: DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        loginCheckResult = loginCheck()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if loginCheckResult == true {
            toTheView(viewName: "mainview")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        guard let email = emailTextfield.text, let passwd = passwdTextField.text else {
            print("email or password is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: passwd) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            self.toTheView(viewName: "mainview")
        }
    }
    
    func loginCheck() -> Bool {
        let auth = Auth.auth().currentUser?.uid
        if auth != nil {
            self.userRef = Database.database().reference().child("users").child(auth!)
            return true
        } else {
            print("auth is nil")
            return false
        }
    }

}
