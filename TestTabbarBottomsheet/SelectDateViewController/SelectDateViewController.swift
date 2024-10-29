//
//  SelectDateViewController.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 28/10/24.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    private var datePicker: UIDatePicker!
    private var submitButton: UIButton!

    var onDateSelected: ((Date?) -> Void)?
    
    private var minimumDay: Int?
    private var maximumDay: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(minimumDay: Int?, maximumDay: Int?) {
        self.minimumDay = minimumDay
        self.maximumDay = maximumDay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupView() {
        view.backgroundColor = .white
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        
        // Calculate the minimum and maximum dates
        let today = Calendar.current.date(from: Calendar.current.dateComponents([Calendar.Component.year, .month, .day], from: Date())) ?? Date()
        if let twoDaysAgo = Calendar.current.date(byAdding: .day, value: minimumDay ?? 0, to: today),
           let fifteenDaysFromNow = Calendar.current.date(byAdding: .day, value: maximumDay ?? 15, to: today) {
            datePicker.minimumDate = twoDaysAgo
            datePicker.maximumDate = fifteenDaysFromNow
        }
        
        
        view.addSubview(datePicker)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        // Setup submit button
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .blue // Set background color to blue
        submitButton.setTitleColor(.white, for: .normal) // Set title color to white for contrast
        submitButton.layer.cornerRadius = 5 // Optional: rounded corners
        submitButton.addTarget(self, action: #selector(submitDate), for: .touchUpInside)
        
        view.addSubview(submitButton)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 100), // Optional: set a width
            submitButton.heightAnchor.constraint(equalToConstant: 44) // Optional: set a height
        ])
    }
    
    
    @objc private func submitDate() {
        let selectedDate = datePicker.date
        onDateSelected?(selectedDate)
        navigationController?.popViewController(animated: true)
    }
    
}
