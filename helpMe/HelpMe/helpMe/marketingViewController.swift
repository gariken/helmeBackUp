//
//  marketingViewController.swift
//  helpMe
//
//  Created by Александр on 24.05.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class marketingViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var marketingPageViewController: marketingPageViewController? {
        didSet {
            marketingPageViewController?.marketingDelegate = self
        }
    }
    
    @IBAction func nextSlide(_ sender: Any) {
        marketingPageViewController?.scrollToNextViewController()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(marketingViewController.didChangePageControlValue), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let marketingPageViewController = segue.destination as? marketingPageViewController {
            self.marketingPageViewController = marketingPageViewController
        }
    }
    
    func didChangePageControlValue() {
        marketingPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension marketingViewController: marketingPageViewControllerDelegate {
    
    func marketingPageViewController(_ marketingPageViewController: marketingPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func marketingPageViewController(_ marketingPageViewController: marketingPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
 
}
