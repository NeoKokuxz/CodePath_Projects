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
import MessageInputBar


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {

    @IBOutlet weak var postTable: UITableView!
    
    var posts = [PFObject]()
    
    var selectedPost : PFObject!
    
    var showCommentBar = false
    
    let commentBar = MessageInputBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postTable.delegate = self
        postTable.dataSource = self
        DataRequest.addAcceptableImageContentTypes(["application/octet-stream"])
        
        postTable.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        commentBar.inputTextView.placeholder = "Add your thoughts to the post!"
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
    }
    
    @objc func keyboardWillBeHidden ( note: Notification){
        commentBar.inputTextView.text = nil
        showCommentBar = false
        becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKeys(["user" , "comments.user"])
        query.limit = 20
        
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.postTable.reloadData()
            }
        }
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showCommentBar
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "loginViewController")
        
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        
        delegate.window?.rootViewController = loginViewController
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let post = posts[section]
        
        //?? operator sets whatever in the left if nil then set it to the value on the right
        let comment = (post["comments"] as? [PFObject] ) ?? []
        
        return comment.count + 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let postDetailInfo = posts[indexPath.section]
        let comments = (postDetailInfo["comments"] as? [PFObject] ) ?? []

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            
            let user = postDetailInfo["user"] as! PFUser
            
            cell.userLabel.text = user.username
            cell.commentLabel.text = postDetailInfo["caption"] as! String
            
            let imageFile = postDetailInfo["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print(urlString)
            
            cell.postImage.af_setImage(withURL: url)
            
            return cell
        } else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            let comment = comments[indexPath.row - 1]
            cell.commentContent.text = comment["text"] as? String
            
            let user = comment["user"] as! PFUser
            cell.commenterName.text = user.username
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            return cell
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = posts[indexPath.section]
        
        let comments = (post["comments"] as? [PFObject] ) ?? []

        print(indexPath.row)
        print(comments.count)
        if (indexPath.row == comments.count + 1) {
            print("clicked!")
            showCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder() 
        }
        
        //remember the post user clicked to comment
        selectedPost = post
        
//        comment["text"] = "This is something neewww!!"
//        comment["post"] = post
//        comment["user"] = PFUser.current()
//
//        post.add(comment, forKey: "comments")
//
//        post.saveInBackground { (success, error) in
//            if success {
//                print(" Comment: ", (comment), " -> comment saved")
//            } else {
//                print(error)
//            }
//        }
    }

    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        //Create comments
        let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["user"] = PFUser.current()!
        
        selectedPost.add(comment, forKey: "comments")
        
        selectedPost.saveInBackground { (success, error) in
            if success {
                print(" Comment: ", (comment), " -> comment saved")
            } else {
                print(error)
            }
        }
        
        postTable.reloadData()
        //Clear/Dismiss input bar
        commentBar.inputTextView.text = nil
        showCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
}
