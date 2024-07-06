//
//  ListDishesViewController.swift
//  Yummie
//
//  Created by husayn on 05/07/2024.
//

import UIKit

class ListDishesViewController: UIViewController {
    
    @IBOutlet weak var dishesTableView: UITableView!
    
    var from: FilterType!
    var stringFilterWith:String!
    var viewModel: ListDishesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerCells()
        viewModel = ListDishesViewModel()
        viewModel.bindMealsToListDishesView = { [weak self] () in
            self?.renderTableViewData()
        }
        title = "\(stringFilterWith ?? "New") Dishes"
        
        switch from {
        case .area:
            viewModel.fetchAllFilteredDishesByArea(area: stringFilterWith)
        case .category:
            viewModel.fetchAllFilteredDishesByCategory(category: stringFilterWith)
        case .ingredient:
            viewModel.fetchAllFilteredDishesByCategory(ingredient: stringFilterWith)
        default:
            break
        }
    }
    
    private func renderTableViewData(){
        DispatchQueue.main.async { [weak self] in
            self?.dishesTableView.reloadData()
        }
    }
    private func registerCells(){
        dishesTableView.register(UINib(nibName: MealTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MealTableViewCell.identifier)
    }
    
}

extension ListDishesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MealDetailViewController.instantiate()
        controller.mealId = viewModel.meals?[indexPath.row].idMeal
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ListDishesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dishesTableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        guard let meals = viewModel.meals else { return UITableViewCell() }
        cell.setupMealTableViewCell(dish: meals[indexPath.row])
        return cell
        
    }
    
    
}
