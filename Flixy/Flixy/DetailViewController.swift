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
    
    // ! swift optional
    var movieSelect : [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieName.text = movieSelect["title"] as? String
        infoLabel.text = movieSelect["overview"] as? String
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

}
