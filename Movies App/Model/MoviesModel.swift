//
//  MoviesModel.swift
//  Movies App
//
//  Created by Peter Emel on 1/8/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import Foundation

class MoviesDataModel {

    var image : String?
    var name : String?
    var year : String?
    var type : String?
    
    init(image:String, name:String, year:String, type:String) {
        self.image = image
        self.name = name
        self.year = year
        self.type = type
    }
}

