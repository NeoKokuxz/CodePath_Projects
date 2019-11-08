//
//  TrailerViewController.swift
//  Flixy
//
//  Created by Naoki on 10/25/19.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    var link = ""
    
    var movie = [[String:Any]]()

    @IBOutlet weak var webView: WKWebView!
        override func viewDidLoad() {
            super.viewDidLoad()
            print("This is trailer Page ", link)
            let url = URL(string: link)!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
               // This will run when the network request returns
               if let error = error {
                  print(error.localizedDescription)
               } else if let data = data {
                  let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                  // TODO: Get the array of movies
                self.movie = dataDictionary["results"] as! [[String:Any]]
                print("Line 33")
    //            print(self.movie[1])
                let movieSelect = self.movie[0]
                let key = movieSelect["key"] as! String
                print(key)
                print(movieSelect)
                let youtubeURL = URL(string : "https://www.youtube.com/watch?v=\(key)")
                //watch?v=\(youtubeKey)"
                let youtubeRequest = URLRequest(url:youtubeURL!)
                self.webView.load(youtubeRequest)

                
                }
            }
            task.resume()
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
