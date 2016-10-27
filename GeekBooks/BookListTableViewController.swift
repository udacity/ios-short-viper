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
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return (presenter?.sections)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (presenter?.bookCount)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

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
