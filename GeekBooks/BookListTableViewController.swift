//
//  BookListTableViewController.swift
//  GeekBooks
//
//  Created by Fernando Rodríguez Romero on 10/26/16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {

    var presenter : BookListPresenter?
    
    // Load the books
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            // read the json file
            if let url = Bundle.main.url(forResource: "geekBooks", withExtension: "json"),
                let data = try? Data(contentsOf: url),
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONArray,
                let books = try? decode(books: json){
                
                let interactor = BookListInteractor(books: books)
                self.presenter = BookListPresenter(interactor: interactor)
                
                // Now let's reload the table view
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                // Something went really wrong with the josn file
                fatalError("JSON parsing went south. Better luck next time! ;-)")
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return (presenter?.sections) ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (presenter?.bookCount) ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)

        return (presenter?.configure(cell: cell, atIndex: indexPath.row))!
    }
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
