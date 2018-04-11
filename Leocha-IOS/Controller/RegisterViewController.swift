//
//  RegisterViewController.swift
//  Leocha-IOS
//
//  Created by Marion FANJAUD on 21/03/2018.
//  Copyright © 2018 Marion FANJAUD. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {


    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func registerPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!){
            (user, error) in
            
            if error != nil {
                print(error!)
                SVProgressHUD.showError(withStatus: "Failed")
            } else {
                print("Registration Successful")
                SVProgressHUD.showSuccess(withStatus: "Succeeded")
                self.performSegue(withIdentifier: "goToWelcome", sender: self)
            }
            SVProgressHUD.dismiss(withDelay: 0.5)
        }
        
    }
    
    

    
    
}
