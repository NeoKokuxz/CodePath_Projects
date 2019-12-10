//
//  SignUpPageViewController.swift
//  Parstagram
//
//  Created by Naoki on 11/15/19.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import Parse

class SignUpPageViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func signupCompleteBtn(_ sender: Any) {
        var user = PFUser()
        user.username = usernameInput.text
        user.password = passwordInput.text
        
        user.signUpInBackground { (sucess, error) in
            if sucess   {
                print("successfully signed up!")
                self.usernameInput.text = nil
                self.passwordInput.text = nil
                self.dismiss(animated: true, completion: nil)
            }else{
//                print("failed to sign up")
                print(error)
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
