//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Naoki on 11/15/19.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func signinBtn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameInput.text!, password: passwordInput.text!){
            (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSeg", sender: nil)
                self.usernameInput.text = nil
                self.passwordInput.text = nil
            }else {
                print("error")
            }
            
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
