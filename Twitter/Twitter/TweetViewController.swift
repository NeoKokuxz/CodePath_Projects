//
//  TweetViewController.swift
//  Twitter
//
//  Created by Naoki on 11/6/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetContent.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tweetBtn(_ sender: Any) {
        //Check if content is empty, if not
        if(!tweetContent.text.isEmpty){
            //post the tweet
            TwitterAPICaller.client?.postTweet(tweetString: tweetContent.text, success: {
                //dismiss self in the closure
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                //if error, print the message the dismiss self
                print(error)
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
