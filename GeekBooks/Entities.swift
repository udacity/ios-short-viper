//
//  Entities.swift
//  GeekBooks
//
//  Created by Fernando Rodríguez Romero on 10/20/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation

typealias Author = String

struct Book{
    
    let title : String
    let imageURL : URL
    let pdfURL : URL
    let authors : [Author]
    let favorite = false
}
