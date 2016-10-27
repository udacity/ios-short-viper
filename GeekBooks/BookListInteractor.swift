//
//  BookListInteractor.swift
//  GeekBooks
//
//  Created by Fernando Rodríguez Romero on 10/26/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation

class BookListInteractor{
    
    private let sortedBooks : [Book]
    
    init(books: [Book]) {
        sortedBooks = books.sorted()
    }
    
    // book by position
    subscript(index: Int)->Book{
        return sortedBooks[index]
    }
    
    //total books
    var count : Int{
        return sortedBooks.count
    }
    
}
