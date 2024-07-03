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
    
    var categories: [DishCategory] = [
        .init(idCategory: "1", strCategory: "Beef", strCategoryThumb: "https://picsum.photos/100/200", strCategoryDescription: "Beef"),
        .init(idCategory: "2", strCategory: "Beef", strCategoryThumb: "https://picsum.photos/100/200", strCategoryDescription: "Chicked"),
        .init(idCategory: "3", strCategory: "Beef", strCategoryThumb: "https://picsum.photos/100/200", strCategoryDescription: "Ice Cream"),
        .init(idCategory: "4", strCategory: "Macrona", strCategoryThumb: "https://picsum.photos/100/200", strCategoryDescription: "Beef"),
        .init(idCategory: "5", strCategory: "Milk", strCategoryThumb: "https://picsum.photos/100/200", strCategoryDescription: "Beef"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        // Do any additional setup after loading the view.
    }
    
    
    private func registerNibs(){
        foodCategoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
    }
    

    

}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
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
