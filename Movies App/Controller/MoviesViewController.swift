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
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    
   
    @IBAction func searchPressed(_ sender: UIButton) {
        moviesArray.removeAll()
        moviesCollectionView.reloadData()
        
        headerLbl.text = "Search Results 🔍"
        
        let movieID = searchTextField.text!
        let encodedString = movieID.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        
        let TMDB_SEARCH = "https://api.themoviedb.org/3/search/multi?api_key=f2a95234eade42f27fdb273fba814302&language=en-US&query=\(encodedString!)&page=1&include_adult=false"
        
        print(TMDB_SEARCH)

        fetchMoviesData(url: TMDB_SEARCH)
        
            SVProgressHUD.show(withStatus: "Loading...")
            Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    
    //Variables
    let TMDB_TRENDING = "https://api.themoviedb.org/3/trending/all/day?api_key=f2a95234eade42f27fdb273fba814302"
    
    var moviesArray = [MoviesDataModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        leftButton.frame = CGRect(x: 16, y: 0, width: 60, height: 150)
        fetchMoviesData(url: TMDB_TRENDING)
        
        
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
            }else{
                print("Error \(String(describing: response.result.error))")
                self.headerLbl.text = "Connection Issues"
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let moviesData = moviesArray[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsController") as? DetailsViewController
        
        vc?.getTitle = moviesData.title
        vc?.getTitle2 = moviesData.title2
        vc?.getImage = moviesData.image
        vc?.getDesc = moviesData.description
        
        print("Image: \(moviesData.image)")


        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func update() {
        SVProgressHUD.dismiss()
    }
    
    
    @IBAction func appNamePressed(_ sender: UIButton) {
        print("Button code excuted")
        headerLbl.text = "Top Trending Today🔥"
        moviesArray.removeAll()
        fetchMoviesData(url: TMDB_TRENDING)
        moviesCollectionView.reloadData()
    }
    
}

