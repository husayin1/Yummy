//
//  FilterDishesViewController.swift
//  Yummie
//
//  Created by husayn on 06/07/2024.
//

import UIKit

class FilterDishesViewController: UIViewController {
    
    @IBOutlet weak var areasCollectionView: UICollectionView!
    
    @IBOutlet weak var ingredientsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var filterViewModel: FilterDishesViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        filterViewModel = FilterDishesViewModel()
        
        
        viewModelBindMethods()
        viewModelCalls()
        // Do any additional setup after loading the view.
    }
    
    
    
}

extension FilterDishesViewController: FilterDishesViewModelDuties{
    
    func viewModelCalls(){
        filterViewModel.fetchAllAreas()
        filterViewModel.fetchAllIngredients()
        filterViewModel.fetchAllCategories()
    }
    
    func viewModelBindMethods(){
        filterViewModel.bindAreasToFilterView = {[weak self] () in
            self?.renderAreasToCollectionView()
        }
        filterViewModel.bindIngredientsToFilterView = {[weak self] () in
            self?.renderIngredientsToCollectionView()
        }
        filterViewModel.bindCategoriesToFilterView = {[weak self] () in
            self?.renderCategoriesToCollectionView()
        }
    }
}
extension FilterDishesViewController: FilterDishesViewNetworkDuties{
    
    func renderAreasToCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.areasCollectionView.reloadData()
        }
    }
    func renderIngredientsToCollectionView(){
        DispatchQueue.main.async{[weak self] in
            self?.ingredientsCollectionView.reloadData()
        }
    }
    func renderCategoriesToCollectionView(){
        DispatchQueue.main.async {[weak self] in
            self?.categoryCollectionView.reloadData()
        }
    }
}

extension FilterDishesViewController: FilterDishesViewNormalDuties{
    func registerNibs() {
        areasCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        ingredientsCollectionView.register(UINib(nibName: IngredientCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: IngredientCollectionViewCell.identifier)
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
}

extension FilterDishesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case areasCollectionView:
            return filterViewModel.areas?.count ?? 0
        case ingredientsCollectionView:
            return filterViewModel.ingredients?.count ?? 0
        case categoryCollectionView:
            return filterViewModel.categories?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case areasCollectionView:
            
            let cell = areasCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            guard let areas = filterViewModel.areas else { break }
            cell.setupAreaCell(area: areas[indexPath.row])
            
            return cell
        case ingredientsCollectionView:
            let cell = ingredientsCollectionView.dequeueReusableCell(withReuseIdentifier: IngredientCollectionViewCell.identifier, for: indexPath) as! IngredientCollectionViewCell
            guard let ingredients = filterViewModel.ingredients else { break }
            cell.setupIngredientCollectionViewCell(ingredint: ingredients[indexPath.row])
            return cell
        case categoryCollectionView:
            
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            guard let categories = filterViewModel.categories else { break }
            cell.setupCategoryCell(category: categories[indexPath.row])
            
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case areasCollectionView:
            guard let meals = filterViewModel.areas else { break }
            let controller = ListDishesViewController.instantiate()
            controller.from = .area
            controller.stringFilterWith = meals[indexPath.row].strArea
            navigationController?.pushViewController(controller, animated: true)
        case ingredientsCollectionView:
            guard let meals = filterViewModel.ingredients else { break }
            let controller = ListDishesViewController.instantiate()
            controller.from = .ingredient
            controller.stringFilterWith = meals[indexPath.row].strIngredient
            navigationController?.pushViewController(controller, animated: true)
            
        case categoryCollectionView:
            guard let meals = filterViewModel.categories else { break }
            let controller = ListDishesViewController.instantiate()
            controller.from = .category
            controller.stringFilterWith = meals[indexPath.row].strCategory
            navigationController?.pushViewController(controller, animated: true)
            
        default: break
        }
    }
    
}


extension FilterDishesViewController: UICollectionViewDelegateFlowLayout{
    
}

protocol FilterDishesViewNetworkDuties {
    func renderAreasToCollectionView()
    func renderCategoriesToCollectionView()
    func renderIngredientsToCollectionView()
}

protocol FilterDishesViewNormalDuties{
    func registerNibs()
}

protocol FilterDishesViewModelDuties {
    func viewModelCalls()
    func viewModelBindMethods()
}

