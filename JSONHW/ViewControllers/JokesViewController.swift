//
//  JokesViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

import UIKit

class JokesViewController: UITableViewController {

    
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)

        // Configure the cell...

        return cell
    }

}
