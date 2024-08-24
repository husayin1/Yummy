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
    var searchController: UISearchController!
    var filteredMeals: [FilteredDishes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerCells()
        viewModel = ListDishesViewModel()
        viewModel.bindMealsToListDishesView = { [weak self] () in
            self?.renderTableViewData()
        }
        title = "\(stringFilterWith ?? "Search For") Dishes"
        
        setupSearchController()
        
        switch from {
        case .area:
            viewModel.fetchAllFilteredDishesByArea(area: stringFilterWith)
        case .category:
            viewModel.fetchAllFilteredDishesByCategory(category: stringFilterWith)
        case .ingredient:
            viewModel.fetchAllFilteredDishesByCategory(ingredient: stringFilterWith)
        default:
            viewModel.searchFor(meal: searchController.searchBar.text ?? "")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    
    private func renderTableViewData(){
        DispatchQueue.main.async { [weak self] in
            self?.dishesTableView.reloadData()
        }
    }
    
    private func registerCells(){
        dishesTableView.register(UINib(nibName: MealTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MealTableViewCell.identifier)
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Dishes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        switch from {
        case .area,.category, .ingredient:
            
            filteredMeals = viewModel.meals?.filter { (meal: FilteredDishes) -> Bool in
                return meal.strMeal.lowercased().contains(searchText.lowercased())
            } ?? []
        default :
            viewModel.searchFor(meal: searchText)
            filteredMeals = viewModel.meals ?? []
        }
        
        dishesTableView.reloadData()
    }
}
extension ListDishesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
}
extension ListDishesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MealDetailViewController.instantiate()
        let meal: FilteredDishes
        if isFiltering() {
            meal = filteredMeals[indexPath.row]
        } else {
            guard let meals = viewModel.meals else { return }
            meal = meals[indexPath.row]
        }
        controller.mealId = meal.idMeal
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ListDishesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMeals.count
        }
        return viewModel.meals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dishesTableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        let meal: FilteredDishes
        if isFiltering() {
            meal = filteredMeals[indexPath.row]
        } else {
            guard let meals = viewModel.meals else { return UITableViewCell() }
            meal = meals[indexPath.row]
        }
        cell.setupMealTableViewCell(dish: meal)
        return cell
    }
}
