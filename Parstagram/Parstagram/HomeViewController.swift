//
//  HomeViewController.swift
//  Parstagram
//
//  Created by Naoki on 11/15/19.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import Parse
import Alamofire


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var postTable: UITableView!
    
    var post = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postTable.delegate = self
        postTable.dataSource = self
    DataRequest.addAcceptableImageContentTypes(["application/octet-stream"])

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("user")
        query.limit = 20
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.post = posts!
                self.postTable.reloadData()
            }
        }
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let postDetailInfo = post[indexPath.row]
        
        let user = postDetailInfo["user"] as! PFUser
        
        cell.userLabel.text = user.username
        cell.commentLabel.text = postDetailInfo["caption"] as! String
        
        let imageFile = postDetailInfo["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        print(urlString)
        
        cell.postImage.af_setImage(withURL: url)
        
        return cell
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
