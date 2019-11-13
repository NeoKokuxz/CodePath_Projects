//
//  TweetViewController.swift
//  Twitter
//
//  Created by Naoki on 11/6/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var tweetContent: UITextView!
    @IBOutlet weak var wordCountNum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tweetContent.becomeFirstResponder()
        wordCountNum.text = "0/140"
        // Do any additional setup after loading the view.
        tweetContent.delegate = self
        
        //Place holder
        placeHolder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func placeHolder(){
        tweetContent.text = "Please tweet your thoughts!"
        tweetContent.textColor = UIColor.lightGray
        tweetContent.returnKeyType = .done
    }
    
    @IBAction func dismiss(_ sender: Any) {
        //end editing when user tap outside of the text field
        view.endEditing(true)
        //if user did not input anything, pull the place holder back to screen
        if (tweetContent.text.isEmpty){
            placeHolder()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Please tweet your thoughts!"){
            textView.text = ""
            textView.textColor = UIColor.black
            textView.becomeFirstResponder()

        }
    }
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
    
    func textView(_ textView:UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        // TODO: Update Character Count Label
        wordCountNum.text = String(newText.count) + "/140"
        //2nd implementation to show character left
        //wordCountNum.text = String(140 - newText.count) + "left"
        
        
        // The new text should be allowed? True/False
        return newText.count < characterLimit
    }
}
