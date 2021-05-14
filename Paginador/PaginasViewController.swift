import UIKit

class PaginasViewController: UIPageViewController {
    
    private lazy var vista1: UIViewController = {
        let storyboard = UIStoryboard(name: "FirstViewController", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "firstViewController") as! FirstViewController
        return viewController
    }()
    private lazy var vista2: UIViewController = {
        let storyboard = UIStoryboard(name: "SecondViewController", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! SecondViewController
        return viewController
    }()
    private lazy var vista3: UIViewController = {
        let storyboard = UIStoryboard(name: "ThirdViewController", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "thirdViewController") as! ThirdViewController
        return viewController
    }()
    
    private lazy var vistas: [UIViewController] = [vista1, vista2, vista3]
    
    private var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        setViewControllers([vista1], direction: .forward, animated: true, completion: nil)
        
        paginador()
        
    }
    
    private func paginador() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 80, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = vistas.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .black
        
        self.view.addSubview(pageControl)
    }
    
}

extension PaginasViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = vistas.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else { return nil }
        guard vistas.count > previousIndex else { return nil }
        
        return vistas[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let index = vistas.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = index + 1
        let total = vistas.count

        guard total != nextIndex else { return nil }
        guard total > nextIndex else { return nil }
        
        return vistas[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let controlladores = pageViewController.viewControllers, let controler1 = controlladores.first,
              let index = vistas.firstIndex(of: controler1) else {
            return
        }
        
        self.pageControl.currentPage = index
        
    }
    
}
