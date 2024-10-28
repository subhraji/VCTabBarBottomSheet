//
//  MainViewController.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 07/10/24.
//

import UIKit

class MainViewController: UIViewController {

    private let actionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Action", style: .plain, target: nil, action: nil)
        button.tintColor = .blue
        return button
    }()
    
    private var bottomSheetView: FirstBottomSheet!
    static var isBottomSheetOpen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupBottomSheet()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        
        // Add shadow
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.1
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navigationController?.navigationBar.layer.shadowRadius = 1
        navigationController?.navigationBar.layer.masksToBounds = false
        
        navigationItem.title = "Vantage Circle"
        navigationItem.rightBarButtonItem = actionButton
        actionButton.target = self
        actionButton.action = #selector(actionButtonTapped)
    }
    
    private func setupBottomSheet() {
        bottomSheetView = FirstBottomSheet()
        bottomSheetView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 300)
        view.addSubview(bottomSheetView)
    }
    
    @objc private func actionButtonTapped() {
        // Only open the bottom sheet
        if !MainViewController.isBottomSheetOpen {
            openBottomSheet()
        }else{
            closeBottomSheet()
        }
    }

    private func openBottomSheet() {
        let targetY = view.frame.height - bottomSheetView.frame.height
        
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetView.frame.origin.y = targetY
            self.bottomSheetView.contentView.frame.size.height = self.bottomSheetView.currentHeight
            self.bottomSheetView.contentView.frame.origin.y = self.bottomSheetView.bounds.height - self.bottomSheetView.currentHeight
            
            self.bottomSheetView.tableView.isHidden = true
            self.bottomSheetView.viewButton.isHidden = false
            
            self.bottomSheetView.demoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)

        }, completion: { [self] _ in
            MainViewController.isBottomSheetOpen = true
        })
    }

    private func closeBottomSheet() {
        let targetY = view.frame.height + 300

        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheetView.frame.origin.y = targetY
            self.bottomSheetView.tableView.isHidden = true
            self.bottomSheetView.isOpenBottomsheet = false
        }, completion: { _ in
            MainViewController.isBottomSheetOpen = false
        })
    }
}

