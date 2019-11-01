//
//  LoginPageViewController.swift
//  Twitter
//
//  Created by Naoki on 10/31/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    //login key
    var loginkey = "userLoggedIn"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: self.loginkey) == true {
            self.performSegue(withIdentifier: "login", sender: self)
        }
    }
    
    //Login Button
    @IBAction func loginBtn(_ sender: Any) {
        
        let APIURL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: APIURL, success: {
            UserDefaults.standard.set(true, forKey: self.loginkey)
            //This will pass to the homepage
            self.performSegue(withIdentifier: "login", sender: self)
            
        }, failure: { (Error) in
            print("Couldn't login!")
        })
    }
    
    //identifier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
