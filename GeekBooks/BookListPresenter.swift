//
//  BookListPresenter.swift
//  GeekBooks
//
//  Created by Fernando Rodríguez Romero on 10/26/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit


class BookListPresenter{
    
    let interactor : BookListInteractor
    
    var sections : Int{
        return 1
    }
    
    var bookCount : Int{
        return interactor.count
    }
    
    func configure(cell: UITableViewCell, atIndex index: Int) -> UITableViewCell {
        
        // get tthe book
        let book = interactor[index]
        cell.textLabel?.text = book.title.capitalized
        cell.detailTextLabel?.text = book.authors.joined(separator: ", ")
        cell.imageView?.image = UIImage(imageLiteralResourceName: "emptyBookCover.png")
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            // Download the real image
            let img = try? Data(contentsOf: book.imageURL)
            
            DispatchQueue.main.async {
                if let img = img{
                    cell.imageView?.image = UIImage(data: img)
                }
            }
        }
        
        
        return cell
    }
    
    
    
    init(interactor : BookListInteractor) {
        self.interactor = interactor
    }
    
}
