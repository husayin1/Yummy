//
//  HomeViewController.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var foodCategoryCollectionView: UICollectionView!
    
    @IBOutlet weak var popularDishesCollectionView: UICollectionView!
    
    @IBOutlet weak var chefSpecialsCollectionView: UICollectionView!
    
    @IBOutlet weak var popularDishesLabel: UILabel!
    
    var selectedCategoryIndex:IndexPath?
    
    var homeViewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        homeViewModel = HomeViewModel()
        
        
        viewModelBindMethods()
        viewModelCalls()
        
        
        selectedCategoryIndex =  IndexPath(item: 0, section: 0)
        popularDishesLabel.text = "Popular \(homeViewModel.categories?[selectedCategoryIndex?.row ?? 0].strCategory ?? "Beef") Dishes"
    }
    
}
extension HomeViewController: HomeViewModelDuties{
    
    func viewModelCalls(){
        homeViewModel.fetchAllFoodCategories()
        homeViewModel.fetchAllFilteredDishes()
        homeViewModel.fetchSpecialMeals()
    }
    
    func viewModelBindMethods(){
        homeViewModel.bindCategoriesToHomeView = {[weak self] () in
            self?.renderCategoriesToCollectionView()
            self?.renderFilteredMealsToCollectionView()
        }
        homeViewModel.bindFilteredMealsToHomeView = {
            [weak self] () in
            self?.renderFilteredMealsToCollectionView()
        }
        homeViewModel.bindSpecialMealsToHomeView = {
            [weak self] () in
            self?.renderSpecialMealsToCollectionView()
        }
    }
}

extension HomeViewController: HomeViewNetworkDuties{
    
    func renderSpecialMealsToCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.chefSpecialsCollectionView.reloadData()
        }
    }
    
    func renderCategoriesToCollectionView(){
        DispatchQueue.main.async { [weak self] in
            self?.foodCategoryCollectionView.reloadData()
        }
    }
    func renderFilteredMealsToCollectionView(){
        DispatchQueue.main.async { [weak self] in
            self?.popularDishesCollectionView.reloadData()
        }
    }
    
}

extension HomeViewController: HomeViewNormalDuties{
    
    func registerNibs(){
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularDishesCollectionView.register(UINib(nibName: DishesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishesCollectionViewCell.identifier)
        chefSpecialsCollectionView.register(UINib(nibName: ChefSpecialCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ChefSpecialCollectionViewCell.identifier)
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case foodCategoryCollectionView:
            return homeViewModel.categories?.count ?? 0
        case popularDishesCollectionView:
            return homeViewModel.filteredDishes?.count ?? 0
        case chefSpecialsCollectionView:
            return homeViewModel.specials?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case foodCategoryCollectionView:
            
            let cell = foodCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            guard let categories = homeViewModel.categories else { break }
            cell.setupCategoryCell(category: categories[indexPath.row])
            
            
            return cell
            
        case popularDishesCollectionView:
            let cell = popularDishesCollectionView.dequeueReusableCell(withReuseIdentifier: DishesCollectionViewCell.identifier, for: indexPath) as! DishesCollectionViewCell
            guard let populars = homeViewModel.filteredDishes else { break }
            cell.setupDishCollectionCell(dish: populars[indexPath.row])
            return cell
        case chefSpecialsCollectionView:
            let cell = chefSpecialsCollectionView.dequeueReusableCell(withReuseIdentifier: ChefSpecialCollectionViewCell.identifier, for: indexPath) as! ChefSpecialCollectionViewCell
            guard let special = homeViewModel.specials else { break }
            cell.setupChefSpecialCollectionViewCell(special: special[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case foodCategoryCollectionView:
            guard let categories = homeViewModel.categories else { break }
            homeViewModel.fetchAllFilteredDishes(category: categories[indexPath.row].strCategory)
            popularDishesLabel.text = "Popular \(categories[indexPath.row].strCategory) Dishes"
        case chefSpecialsCollectionView:
            guard let meal = homeViewModel.specials else { break }
            let controller = MealDetailViewController.instantiate()
            controller.mealId = meal[indexPath.row].idMeal
            
            navigationController?.pushViewController(controller, animated: true)
            print(meal[indexPath.row].idMeal)
        case popularDishesCollectionView:
            guard let populars = homeViewModel.filteredDishes else { break }
            
            let controller = MealDetailViewController.instantiate()
            controller.mealId = populars[indexPath.row].idMeal
            
            navigationController?.pushViewController(controller, animated: true)
            print( populars[indexPath.row].idMeal)
        default: break
            
        }
        selectedCategoryIndex = indexPath
    }
}
/*
extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
}*/

protocol HomeViewNetworkDuties {
    func renderCategoriesToCollectionView()
    func renderFilteredMealsToCollectionView()
    func renderSpecialMealsToCollectionView()
}

protocol HomeViewNormalDuties{
    func registerNibs()
}

protocol HomeViewModelDuties {
    func viewModelCalls()
    func viewModelBindMethods()
}
