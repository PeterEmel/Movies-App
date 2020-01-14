//
//  DetailsViewController.swift
//  Movies App
//
//  Created by Peter Emel on 1/11/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    
    //Variables
    var getTitle : String!
    var getTitle2 : String!
    var getImage : String!
    var getDesc : String!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        //print("GET: \(getTitle)")
        
        if getTitle == "" {
            titleLbl.text = getTitle2
        }else{
            titleLbl.text = getTitle
        }
        
        if let url = Foundation.URL(string: "https://image.tmdb.org/t/p/w500\(getImage!)"){
            do{
                let data = try Data(contentsOf: url)
                imageView.image = UIImage(data: data)
            }catch let err{
                print("Error: \(err.localizedDescription)")
                imageView.image = UIImage(named: "noim")
            }
        }
        
        descriptionLbl.text = getDesc
    }

}
