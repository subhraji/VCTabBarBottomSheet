//
//  ThirdViewController.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 29/10/24.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let data = [
        ["Mango", "Orange", "Banana"],
        ["One", "Two", "Three"],
        ["last one"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DemoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        header.backgroundColor = .orange
        footer.backgroundColor = .green
        
        let label = UILabel(frame: header.bounds)
        label.text = "Hello World"
        label.textAlignment = .center
        header.addSubview(label)
        
        tableView.tableHeaderView = header
        tableView.tableFooterView = footer
    }
}

extension ThirdViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0 // Height of the header
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear // or any other color if you want to see the space
        return headerView
    }
}

extension ThirdViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DemoTableViewCell.identifier, for: indexPath) as! DemoTableViewCell
        cell.myLabel.text = data[indexPath.section][indexPath.row]
        return cell
    }
}
