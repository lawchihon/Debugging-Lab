//
//  LevelFiveViewController.swift
//  Debugging
//
//  Created by Nicholas Aiwazian on 2/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

// TableView with cells with wrong descriptions
class LevelFiveViewController: GameLevelViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
    var movies: [AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "movieCell")
        self.loadJSON()
    }
    
    func loadJSON() {
        let filePath = Bundle.main.path(forResource: "Movies", ofType: "json")
        let fileData = try? Data.init(contentsOf: URL(fileURLWithPath: filePath!))
        
        do {
            if let responseDictionary = try JSONSerialization.jsonObject(with: fileData!,
                options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String:AnyObject] {
                    
                    if let movies = responseDictionary["movies"] as? [AnyObject] {
                        self.movies = movies
                        self.tableView.reloadData()
                    }
            }
        } catch {
            print("Error parsing JSON")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieTableViewCell
        let movie = self.movies[indexPath.row] as? [String:AnyObject]
        
        let posterUrl = URL(string: posterBaseUrl + (movie!["poster_path"] as! String))
        
        cell.posterImageView.setImageWith(posterUrl!)
        cell.titleLabel.text = movie!["title"] as? String
        
        if let movieOverview = movie!["overview"] as? String {
            cell.overviewLabel.text = movieOverview
        }
        else {
            cell.overviewLabel.text = "Not available"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.didFinishLevel()
    }
}
