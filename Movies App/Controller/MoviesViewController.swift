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
    
    
    var movieCellObj = MovieCell()
    var moviesArray = [MoviesDataModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        //fetchIMDB()
        
        
    }
    func fetchIMDB() {
//        let myURLString = "https://www.imdb.com/chart/top"
//        guard let myURL = URL(string: myURLString) else {
//            print("Error: \(myURLString) doesn't seem to be a valid URL")
//            return
//        }
//
//        do {
//            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
//            //print("HTML : \(myHTMLString)")
//
//        } catch let error {
//            print("Error: \(error)")
//        }
    }
    
    
    func fetchMoviesData(url:String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, Got Movies Data")
                let movieJSON:JSON = JSON(response.result.value!)
                print(movieJSON)
                self.moviesDatajson(json: movieJSON)
            }
        }
    }
    
    func moviesDatajson(json:JSON) {
        
        for (_, subjson) in json["Search"] {
            let image = subjson["Poster"].stringValue
            let name = subjson["Title"].stringValue
            let year = subjson["Year"].stringValue
            let type = subjson["Type"].stringValue
            
            let moviesData = MoviesDataModel(image: image, name: name, year: year, type: type)
            
            moviesArray.append(moviesData)
            //print(moviesArray)
            //moviesCollectionView.reloadData()
            
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

