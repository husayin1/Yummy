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
    
    var networkIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    var selectedCategoryIndex:IndexPath?
    
    var homeViewModel: HomeViewModel!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicator()
        registerNibs()
        homeViewModel = HomeViewModel()
        
        selectedCategoryIndex =  IndexPath(item: 0, section: 0)
        popularDishesLabel.text = "Popular \(homeViewModel.categories?[selectedCategoryIndex?.row ?? 0].strCategory ?? "Beef") Dishes"
        
        viewModelBindMethods()
        viewModelCalls()
    }
        
}
extension HomeViewController: HomeViewModelDuties{
    
    func viewModelCalls(){
        networkIndicator.startAnimating()
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
            self?.networkIndicator.stopAnimating()
        }
    }
    
    func renderCategoriesToCollectionView(){
        DispatchQueue.main.async { [weak self] in
            self?.foodCategoryCollectionView.reloadData()
            self?.networkIndicator.stopAnimating()
        }
    }
    func renderFilteredMealsToCollectionView(){
        DispatchQueue.main.async { [weak self] in
            self?.popularDishesCollectionView.reloadData()
            self?.networkIndicator.stopAnimating()
        }
    }
    
}

extension HomeViewController: HomeViewNormalDuties{
 
    func registerNibs(){
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularDishesCollectionView.register(UINib(nibName: DishesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishesCollectionViewCell.identifier)
        chefSpecialsCollectionView.register(UINib(nibName: ChefSpecialCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ChefSpecialCollectionViewCell.identifier)
    }
    
    func setupIndicator(){
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
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
            
            if indexPath == selectedCategoryIndex {
                cell.changeColor(to: .red) // Selected color
            } else {
                cell.changeColor(to: .black) // Default color
            }
            
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
            networkIndicator.startAnimating()
            homeViewModel.fetchAllFilteredDishes(category: categories[indexPath.row].strCategory)
            popularDishesLabel.text = "Popular \(categories[indexPath.row].strCategory) Dishes"

        default: break
            
        }
        if let previousIndex = selectedCategoryIndex {
                    let previousCell = foodCategoryCollectionView.cellForItem(at: previousIndex) as? CategoryCollectionViewCell
                    previousCell?.changeColor(to: .black) // Revert previous cell to default color
                }
                
                let selectedCell = foodCategoryCollectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
                selectedCell?.changeColor(to: .red) // Change the color of the selected cell
                
                selectedCategoryIndex = indexPath
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
}

protocol HomeViewNetworkDuties {
    func renderCategoriesToCollectionView()
    func renderFilteredMealsToCollectionView()
    func renderSpecialMealsToCollectionView()
}

protocol HomeViewNormalDuties{
    func registerNibs()
    func setupIndicator()
}

protocol HomeViewModelDuties {
    func viewModelCalls()
    func viewModelBindMethods()
}
