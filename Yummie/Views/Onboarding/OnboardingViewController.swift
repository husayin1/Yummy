//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by husayn on 03/07/2024.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    
    @IBOutlet weak var sliderButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var slides: [OnboardingSlide] = []
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                sliderButton.setTitle("Get Started", for: .normal)
            }else{
                sliderButton.setTitle("Next", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        slides = [
            OnboardingSlide(title: "Delicious Dishes",
                            description: "Experience a variety of amazing dishes from different culutres around the world.", image: UIImage(named: "slide1") ?? .strokedCheckmark ),
            OnboardingSlide(title: "Personalized Recipe Discovery",
                            description: "Tell us your food preferences and we'll serve you delicious recipes ideas.", image: UIImage(named: "slide3") ?? .strokedCheckmark),
            OnboardingSlide(title: "All Your Favorite Recipes In One Place",
                            description: "Save time on planning by having your favorite recipes within reach", image: UIImage(named: "slide2") ?? .strokedCheckmark )
        ]
        pageControl.numberOfPages = slides.count
    }
    
    @IBAction func slideOnBoarding(_ sender: Any) {
        if currentPage == slides.count - 1 {
            print("Go To Next View")
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
 

}


extension OnboardingViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setupSlide(slides[indexPath.row])
        
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - 10
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onboardingCollectionView.frame.width - 10, height: onboardingCollectionView.frame.height)
    }
}
