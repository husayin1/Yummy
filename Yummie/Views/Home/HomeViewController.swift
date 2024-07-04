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
    
    var categories: [DishCategory] = []
    
    var populars: [FilteredDishes] = []
    
    var homeViewModel: HomeViewModel!
    
    var selectedCategoryIndex:IndexPath? = IndexPath(item: 0, section: 0)
    
    var networkIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicator()
        registerNibs()
        homeViewModel = HomeViewModel()
        
        homeViewModel.bindCategoriesToHomeView = {[weak self] () in
            self?.renderCategoriesToCollectionView()
            self?.renderFilteredMealsToCollectionView()
        }
        homeViewModel.bindFilteredMealsToHomeView = {
            [weak self] () in
            self?.renderFilteredMealsToCollectionView()
        }
        
        homeViewModel.fetchAllFoodCategories()
        homeViewModel.fetchAllFilteredDishes()
    }
    
    
}

extension HomeViewController {
    
    private func registerNibs(){
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularDishesCollectionView.register(UINib(nibName: DishesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishesCollectionViewCell.identifier)
        
    }
    
    private func renderCategoriesToCollectionView(){
        DispatchQueue.main.async {
            self.categories = self.homeViewModel.categories ?? [DishCategory]()
            self.foodCategoryCollectionView.reloadData()
            self.networkIndicator.stopAnimating()
        }
    }
    private func renderFilteredMealsToCollectionView(){
        DispatchQueue.main.async {
            self.populars = self.homeViewModel.filteredDishes ?? [FilteredDishes]()
            self.popularDishesCollectionView.reloadData()
            self.networkIndicator.stopAnimating()
        }
    }
    
    private func setupIndicator(){
        networkIndicator.startAnimating()
        view.addSubview(networkIndicator)
    }
    
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case foodCategoryCollectionView:
            return categories.count
        case popularDishesCollectionView:
            return populars.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case foodCategoryCollectionView:
            
            let cell = foodCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setupCategoryCell(category: categories[indexPath.row])
            
            if indexPath == selectedCategoryIndex {
                cell.changeColor(to: .red) // Selected color
            } else {
                cell.changeColor(to: .black) // Default color
            }
            
            return cell
            
        case popularDishesCollectionView:
            let cell = popularDishesCollectionView.dequeueReusableCell(withReuseIdentifier: DishesCollectionViewCell.identifier, for: indexPath) as! DishesCollectionViewCell
            
            cell.setupDishCollectionCell(dish: populars[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case foodCategoryCollectionView:
            homeViewModel.fetchAllFilteredDishes(category: categories[indexPath.row].strCategory)
            print(categories[indexPath.row])
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
