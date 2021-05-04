//
//  JokesViewController.swift
//  JSONHW
//
//  Created by Кирилл Нескоромный on 04.05.2021.
//

import UIKit

class JokesViewController: UITableViewController {

    var jokes: [Joke] = []
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
            fetchJoke(from: APIManager.shared.joke)
            
            

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return jokes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath) as! JokeTableViewCell
        
        let joke = jokes[indexPath.row]
        
        cell.configureCell(with: joke)
        return cell
    }
    
    func fetchJoke(from url: String?) {
        NetworkManager.shared.fetchJoke(from: url) { jokes in
            self.jokes = jokes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

