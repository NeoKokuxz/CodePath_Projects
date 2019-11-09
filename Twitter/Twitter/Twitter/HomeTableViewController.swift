//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Naoki on 10/31/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var tweetNums : Int!
    
    let myRefreashControl = UIRefreshControl()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        
        myRefreashControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreashControl
    }
    
    @objc func loadTweets(){
        
        tweetNums = 20
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParmas = ["count": tweetNums]
        
        //make api access
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParmas, success: { (tweets : [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            //reload data
            self.tableView.reloadData()
            //after data loaded, stop the refresh
            self.myRefreashControl.endRefreshing()
        }, failure: { (Error) in
            print("Couldn't get tweets")
        })
    }
    
    func loadMoreTweets() {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        tweetNums += 20
        let myParmas = ["count": tweetNums]
        
        //make api access
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParmas, success: { (tweets : [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            //reload data
            self.tableView.reloadData()
            //after data loaded, stop the refresh
            self.myRefreashControl.endRefreshing()
        }, failure: { (Error) in
            print("Couldn't get tweets")
        })
        
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
//        cell.tweetImage
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.nameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.tweetImage.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweets()
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
