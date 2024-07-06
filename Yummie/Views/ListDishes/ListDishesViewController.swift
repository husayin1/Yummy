//
//  ListDishesViewController.swift
//  Yummie
//
//  Created by husayn on 05/07/2024.
//

import UIKit

class ListDishesViewController: UIViewController {

    @IBOutlet weak var dishesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCells()
        title = "Searching"
    }
    

    private func registerCells(){
        dishesTableView.register(UINib(nibName: MealTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MealTableViewCell.identifier)
    }

}

extension ListDishesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MealDetailViewController.instantiate()
        controller.mealId = "5575"
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ListDishesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
