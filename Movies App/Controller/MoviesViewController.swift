//
//  ViewController.swift
//  Movies App
//
//  Created by Peter Emel on 1/8/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    //Outlets
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchPressed(_ sender: UIButton) {
        moviesArray.removeAll()
        moviesCollectionView.reloadData()
        
        let movieID = searchTextField.text!
        //let fileUrl = OMDB_API + movieID
        let encodedString = movieID.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        let url = OMDB_API + encodedString!
        
        fetchMoviesData(url: url)
        
            SVProgressHUD.show(withStatus: "Loading...")
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    
    //Variables
    let OMDB_API = "http://www.omdbapi.com/?apikey=db8b14a5&s="
    let i = "i=tt3896198"
    
    let TMDB = "https://api.themoviedb.org/3/trending/all/day?api_key=f2a95234eade42f27fdb273fba814302"
    
    
    var movieCellObj = MovieCell()
    var moviesArray = [MoviesDataModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        fetchMoviesData(url: TMDB)
        
        
    }

    
    
    func fetchMoviesData(url:String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, Got Movies Data")
                
                SVProgressHUD.show(withStatus: "Loading...")
                Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                
                let movieJSON:JSON = JSON(response.result.value!)
                //print(movieJSON)
                self.moviesDatajson(json: movieJSON)
            }
        }
    }
    
    func moviesDatajson(json:JSON) {
        
        for (_, subjson) in json["results"] {
            let poster = subjson["poster_path"].stringValue
            let title = subjson["title"].stringValue
            let title2 = subjson["original_name"].stringValue
            let year = subjson["release_date"].stringValue
            let type = subjson["media_type"].stringValue
            let rating = subjson["vote_average"].doubleValue
            let description = subjson["overview"].stringValue
            let image = subjson["backdrop_path"].stringValue
            
            let moviesData = MoviesDataModel(poster: poster, title: title, title2: title2, year: year, type: type, rating:rating, description:description, image:image)
            
            moviesArray.append(moviesData)
            
        }
            
        //movieCellObj.updateUI(data: moviesData)
        print(moviesArray.count)
        moviesCollectionView.reloadData()
        update()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCell{
        
        cell.updateUI(moviesData: moviesArray[indexPath.row])

            
        return cell
        
        }else{
            return UICollectionViewCell()
        }
    }
    @objc func update() {
        SVProgressHUD.dismiss()
    }

}

