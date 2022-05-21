//
//  PageControl.swift
//  WeatherAppV2
//
//  Created by dan4 on 15.05.2022.
//

import UIKit

class MainPageControl: UIPageViewController {
    
    // MARK: - Parametres
    var pages: [UIViewController] = [CurrentLocationWeather()]
    
    // MARK: - Iinits
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        dataSource = self
        delegate = nil
        pages.append(CitiesListView())
        
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    
    }
    
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension MainPageControl: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
        
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        guard let firstVC = pageViewController.viewControllers?.first else {
            return 0
        }
        guard let firstVCIndex = pages.firstIndex(of: firstVC) else {
            return 0
        }

        return firstVCIndex
        
    }
    
}

// MARK: - Extension for UIPageController
extension UIPageViewController {

    var scrollView: UIScrollView? {
        return view.subviews.first { $0 is UIScrollView } as? UIScrollView
    }

}
