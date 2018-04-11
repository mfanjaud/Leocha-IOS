//
//  LogInViewController.swift
//  Leocha-IOS
//



import UIKit
import Firebase
import SVProgressHUD


class LogInViewController: UIViewController {

    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        //Log in the user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!){ (user,error) in
            SVProgressHUD.show()
            
            if error != nil {
                print(error!)
                SVProgressHUD.showError(withStatus: "Failed")
            }
            else {
                print("Login successful!")
                SVProgressHUD.showSuccess(withStatus: "Succeeded")
                self.performSegue(withIdentifier: "goToWelcome", sender: self)
            }
            SVProgressHUD.dismiss(withDelay: 0.5)
        }
    }

    
}  
