//
//  JSONProcessing.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 8/19/16.
//  Copyright © 2016 Fernando Rodríguez Romero. All rights reserved.
//

import UIKit


//MARK: - Errors
enum JSONErrors : Error{
    case missingField(name:String)
    case incorrectValue(name: String, value: String)
    case emptyJSONObject
    case emptyJSONArray
}


//MARK: - Aliases
typealias JSONObject    = String    // We'll only receive strings
typealias JSONDictionary = [String : JSONObject]
typealias JSONArray = [JSONDictionary]

//MARK: - Decodification
func decode(book dict: JSONDictionary) throws -> Book{
    
   // validate first
    try validate(dictionary: dict)
    
    // extract from dict
    func extract(key: String) -> String{
        return dict[key]!   // we know it can't be missing because we validated first!
    }
    
    // parsing
    let authors = parseCommaSeparated(string: extract(key: "authors"))
    let imgURL = URL(string: extract(key: "image_url"))!
    let pdfURL = URL(string: extract(key: "pdf_url"))!
    let title = extract(key: "title").capitalized
    
    
    return Book(title: title, imageURL: imgURL, pdfURL: pdfURL, authors: authors)
    
}

func decode(book dict: JSONDictionary?) throws -> Book{
    
    guard let d = dict else {
        throw JSONErrors.emptyJSONObject
    }
    return try decode(book:d)
}

func decode(books dicts: JSONArray) throws -> [Book]{
    
    return try dicts.flatMap{
        try decode(book:$0)
    }
}

func decode(books dicts: JSONArray?) throws -> [Book]{
    guard let ds = dicts else {
        throw JSONErrors.emptyJSONArray
    }
    return try decode(books: ds)
}



//MARK: - Validation
// Validation should be kept waya from processing to
// insure the single responsability principle
// https://medium.com/swift-programming/why-swift-guard-should-be-avoided-484cfc2603c5#.bd8d7ad91
private
func validate(dictionary dict: JSONDictionary) throws{
    
    func isMissing() throws{
        for key in dict.keys{
            guard let value = dict[key] else{
                throw JSONErrors.missingField(name: key)
            }
            guard value.characters.count > 0  else {
                throw JSONErrors.incorrectValue(name: key, value: value)
            }
        }
        
    }
    
    try isMissing()
    
}


//MARK: - Parsing
func parseCommaSeparated(string s: String)->[String]{
    
    return s.components(separatedBy: ",").map({ $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }).filter({ $0.characters.count > 0})
}

