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
        
        if let url = Foundation.URL(string: moviesData.image ?? "https://cdn.onlinewebfonts.com/svg/img_574463.png"){
            do{
                let data = try Data(contentsOf: url)
                movieImageView.image = UIImage(data: data)
            }catch let err{
                print("Error: \(err.localizedDescription)")
            }
        }
        print("Try: \(String(describing: moviesData.name))")
        movieLbl.text = moviesData.name
        yearLbl.text = moviesData.year
        ratingLbl.text = moviesData.rating
        
    }
}
