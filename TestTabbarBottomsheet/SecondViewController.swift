//
//  SecondViewController.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 07/10/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var selectDateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
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
        
        navigationItem.title = "Vantage circle"
    }

    @IBAction func tapOnSelectButton(_ sender: UIButton) {
        //navigateToSelectDateView()
        navigateToThirdView()
    }
    
    private func navigateToThirdView(){
        let thirdVc = ThirdViewController()
        navigationController?.pushViewController(thirdVc, animated: true)
    }
    
    private func navigateToSelectDateView(){
        let minimumDay = -2
        let maximumDay = 2
        
        let selectDateVC = SelectDateViewController(minimumDay: minimumDay, maximumDay: maximumDay)
        
        selectDateVC.onDateSelected = { selectedDate in
            if let date = selectedDate {
                print("Selected Date: \(self.printDate(selectedDate: date))")
            } else {
                print("No date selected")
            }
        }
        
        navigationController?.pushViewController(selectDateVC, animated: true)
    }
    
    
    private func printDate(selectedDate: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formattedDate = dateFormatter.string(from: selectedDate)
        return formattedDate
    }
}
