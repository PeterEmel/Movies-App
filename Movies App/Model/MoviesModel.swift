//
//  MoviesModel.swift
//  Movies App
//
//  Created by Peter Emel on 1/8/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import Foundation

class MoviesDataModel {

    var poster : String?
    var title : String?
    var title2 : String?
    var year : String?
    var type : String?
    var rating : Double?
    var description : String?
    var image : String?
    
    
    init(poster:String, title:String, title2:String, year:String, type:String, rating:Double, description:String, image:String) {
        self.poster = poster
        self.title = title
        self.title2 = title2
        self.year = year
        self.type = type
        self.rating = rating
        self.description = description
        self.image = image
    }
}

