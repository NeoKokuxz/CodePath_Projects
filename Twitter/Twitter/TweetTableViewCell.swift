//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Naoki on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favorBtn: UIButton!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var numLikes: UILabel!
    @IBOutlet weak var numRetweets: UILabel!
    
    var favorited : Bool = false
    var tweetID : Int = -1
    var retweeted : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func setFavor(_ isFavorited : Bool) {
        favorited = isFavorited
        if (favorited == true){
            favorBtn.setImage(UIImage(named : "favor-icon-red"), for: UIControl.State.normal)
        }else{
            favorBtn.setImage(UIImage(named : "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favorTweet(_ sender: Any) {
        if(favorited != true){
            TwitterAPICaller.client?.favorTweet(tweetID: tweetID, success: {
                self.setFavor(true)
                let likes = Int(self.numLikes.text!)
                self.numLikes.text = "\(likes! + 1)"
            }, failure: { (error) in
                print(error)
            })
        }else{
            TwitterAPICaller.client?.unFavorTweet(tweetID: tweetID, success: {
                self.setFavor(false)
                let likes = Int(self.numLikes.text!)
                self.numLikes.text = "\(likes! - 1)"
            }, failure: { (error) in
                print(error)
            })
        }
    }
    
    func setReTweeted (_ retweeted:Bool){
        if(retweeted == true){
            retweetBtn.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetBtn.isEnabled = false
        }else{
            retweetBtn.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetBtn.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
//        if(retweeted == true){
            TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
                self.setReTweeted(true)
                print(self.retweeted)
            }, failure: { (error) in
                print(error)
            })
//        }
//        else{
//            TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
//                self.setReTweeted(false)
//                print(self.retweeted)
//            }, failure: { (error) in
//                print(error)
//            })
//        }
    }
}
