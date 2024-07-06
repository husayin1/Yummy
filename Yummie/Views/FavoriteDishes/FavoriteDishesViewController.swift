//
//  FavoriteDishesViewController.swift
//  Yummie
//
//  Created by husayn on 05/07/2024.
//

import UIKit

class FavoriteDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Favorites"
        registerCells()
    }
    private func registerCells(){
        tableView.register(UINib(nibName: MealTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MealTableViewCell.identifier)
    }
    
}

extension FavoriteDishesViewController: UITableViewDelegate {
    
}

extension FavoriteDishesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
