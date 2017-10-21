//
//  ViewController.swift
//  iOS_Workshop_SdHacks
//
//  Created by Shixuan Li on 10/21/17.
//  Copyright © 2017 Shixuan Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // "?"的意思是check是否是nil但是不crash，"??"代表了如果是nil，则返回0.
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        // for: stands for name of the parameter
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! movieCell
        let index = indexPath.row
        
//        cell.movie = self.movies?[indexPath.row]
        cell.titleLabel.text = movies![indexPath.row]["title"] as! String
        
        let image_base_url = "https://image.tmdb.org/t/p/w342"
        if let url = NSURL(string: image_base_url + (movies![indexPath.row]["poster_path"] as! String)) {
            if let data = NSData(contentsOf: url as URL) {
                cell.movieImageView.image = UIImage(data: data as Data)
            }
        }
        
        return cell
    }
    

    var movies: [NSDictionary]? {
        didSet {
            // Run when the variable is set
//            moviesTableView.reloadData()
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        moviesTableView.rowHeight = 144.0
        
        moviesTableView.dataSource = self
        loadMovieData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadMovieData() {
        // download data about movies
        let endpoint = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        // url
        // 这里的"!"意思是，url是一个optional variable, 可能是actual thing或者nil，"!"代表，如果url是nil，则crash.
        let url = URL(string: endpoint)!
        
        // request
        let urlRequest = URLRequest(url: url)
        
        // session
        let session = URLSession.shared
        
        // put the data into the "movies" array
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            // parse the result as JSON
            // 这里也可以用 if data != nil. 但是需要接下来unwrap data因为data是optional variable.
            if let data = data {
                if let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as?
                    NSDictionary {
                    self.movies = dataDictionary["results"] as! [NSDictionary]
                    print(self.movies)
                    }
            }
            
        })
        
        task.resume()
        
        // tell the tableview that the array has data
        
        
        }
    // download data about movies currently in theaters
    
    // insert movie titles into each cell
}

