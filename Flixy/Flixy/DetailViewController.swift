 //
//  DetailViewController.swift
//  Flixy
//
//  Created by Naoki on 10/23/19.
//  Copyright © 2019 Naoki. All rights reserved.
//

import UIKit
import AlamofireImage
 
class DetailViewController: UIViewController {

    @IBOutlet weak var bgPoster: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    
    // ! swift optional
    var movieSelect : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieName.text = movieSelect["title"] as? String
        infoLabel.text = movieSelect["overview"] as? String
        date.text = movieSelect["release_date"] as? String
        //If the size of the info is sorten by ...
        //use infoLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movieSelect["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        let bgURL = "https://image.tmdb.org/t/p/w780"
        let backgroundPath = movieSelect["backdrop_path"] as! String
        let backgroundURL = URL(string: bgURL + backgroundPath)
        
        poster.af_setImage(withURL: posterUrl!)
        bgPoster.af_setImage(withURL: backgroundURL!)
    }
     

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let movieID = movieSelect["id"] as! Int
        let base = "https://api.themoviedb.org/3/movie/"
        let end = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let url = String(base + String(movieID) + end)
    
        print("This is movie ID")
        print(movieID)

        print(url)
        let vc = segue.destination as! Trailer1ViewController
        vc.link = url
    }

}
