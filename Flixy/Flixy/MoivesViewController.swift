//
//  MoivesViewController.swift
//  Flixy
//
//  Created by Naoki on 10/16/19.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import AlamofireImage

class MoivesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
     
    var movie = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
              // TODO: Store the movies in a property to use elsewhere
            
              // TODO: Reload your table view data
            self.tableView.reloadData()

           }
        }
        task.resume()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Set up int according to the # of movies
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //identifier for the cell in storyboard, and as! MovieCell is the class file
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        let movieName = movie[indexPath.row]
        let title = movieName["title"] as! String
        let info = movieName["overview"] as! String
        
        
        cell.titleLabel.text = title
        cell.infoLabel.text = info
        
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movieName["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.movieImage.af_setImage(withURL: posterUrl!)
        
        return cell
    }
    
    //Navigation to info page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //Find the movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movieTap = movie[indexPath.row]
        
        //pass the selected movie
        let detailViewController = segue.destination as! DetailViewController
        
        detailViewController.movieSelect = movieTap
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
