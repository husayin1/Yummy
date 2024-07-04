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
    
    var homeViewModel: HomeViewModel!
    
    var networkIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicator()
        registerNibs()
        homeViewModel = HomeViewModel()
        
        homeViewModel.bindCategoriesToHomeView = {[weak self] () in
            self?.renderCategoriesToCollectionView()
        }
        homeViewModel.fetchAllFoodCategories()
    }
    
    
}

extension HomeViewController {
    
    private func registerNibs(){
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
    }
    
    private func renderCategoriesToCollectionView(){
        DispatchQueue.main.async {
            self.categories = self.homeViewModel.categories ?? [DishCategory]()
            self.foodCategoryCollectionView.reloadData()
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
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = foodCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.setupCategoryCell(category: categories[indexPath.row])
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
}
