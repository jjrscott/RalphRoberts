//
//  CharactersViewController.swift
//  RalphRoberts
//
//  Created by John Scott on 10/05/2018.
//  Copyright © 2018 John Scott. All rights reserved.
//

import UIKit

private struct ReuseIdentifier
{
    static let HeroViewCell = "HeroViewCell"
}

class CharactersViewController: UITableViewController {
    
    public var characters : [MarvelConnector.Character]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.HeroViewCell, for: indexPath)

        if let character = characters?[indexPath.row]
        {
            cell.textLabel?.text = character.name
        }
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let heroViewController = segue.destination as? HeroViewController,
            let indexPath = tableView.indexPathForSelectedRow,
            let character = characters?[indexPath.row]
        {
            heroViewController.character = character
        }
    }
}
