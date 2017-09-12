//
//  MasterViewController.swift
//  DublinBusRTPI
//
//  Created by Abdulaziz Ismail on 12/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    lazy var searchByStopIdViewController: SearchTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchTableViewController
        self.add(asChildViewController: viewController)
        
        return viewController
        
    }()
    
    lazy var searchByAddressViewController: SearchByAddressTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "SearchByAddress") as! SearchByAddressTableViewController
        self.add(asChildViewController: viewController)
        
        return viewController
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupViews()
    }
    
    func setupViews() {
        setupSegmentedControl()
        
        updateView()
    }
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: searchByAddressViewController)
            add(asChildViewController: searchByStopIdViewController)
        } else {
            remove(asChildViewController: searchByStopIdViewController)
            add(asChildViewController: searchByAddressViewController)
        }
        
    }
    
    private func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "SearchByStopId", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "SearchByAdress", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    //actions
    
    func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    

}
