//
//  MovieCell.swift
//  Movies App
//
//  Created by Peter Emel on 1/8/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import Alamofire

class MovieCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    
    //Variables
    private var moviesData : MoviesDataModel!
    
    
  
    func updateUI(moviesData:MoviesDataModel) {
        self.moviesData = moviesData
        
        if let url = Foundation.URL(string: "https://image.tmdb.org/t/p/w92\(moviesData.poster!)"){
            do{
                let data = try Data(contentsOf: url)
                movieImageView.image = UIImage(data: data)
            }catch let err{
                print("Error: \(err.localizedDescription)")
                movieImageView.image = UIImage(named: "noim")
            }
        }
        if moviesData.title!.isEmpty {
            movieLbl.text = moviesData.title2
        }else{
            movieLbl.text = moviesData.title
        }
        yearLbl.text = moviesData.type
        
        let dec = Double(round(10*moviesData.rating!)/10)
        ratingLbl.text = String(dec)
        
    }
}
