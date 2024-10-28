//
//  FirstBottomSheet.swift
//  TestTabbarBottomsheet
//
//  Created by Subhrajit Deb on 07/10/24.
//

import UIKit

//class NudgePresenter {
//
//    private var nudges:[VCNudge]
//
//    init(nudges: [VCNudge]) {
//        self.nudges = nudges
//    }
//
//    func getNudgeCard(_ nudge:VCNudge)->UICollectionViewCell {
//        switch nudge.type {
//        case .default:
//            //return DefaultNudgeCollectionViewWithDataSetAsNudge
//            break
//        case .wallet:
//            //return WalletSummaryCellWithDataSetAsNudge
//            break
//        case .challenge:
//            //return ChallengeSummaryCellWithDataSetAsNudge
//            break
//        case .offerNudge:
//            <#code#>
//        case .userInteraction:
//            <#code#>
//        }
//    }
//
//    func getElementCellForNudge(_ nudge:VCNudge)->UITableViewCell {
//        switch nudge.type {
//        case .default:
//            //return DefaultNudgeChildTableViewCellWithDataSetAsNudge.Child
//            break
//        case .wallet:
//            //return DefaultWalletChildTableViewCellWithDataSetAsNudge.Child
//            break
//        case .challenge:
//            //return ChallengeSummaryCellWithDataSetAsNudge
//            break
//        case .offerNudge:
//            <#code#>
//        case .userInteraction:
//            <#code#>
//        }
//    }
//}


import UIKit

enum NudgeType {
    case `default`
    case wallet
    case challenge
    case offerNudge
    case userInteraction
}

struct VCNudge {
    let type: NudgeType
    let title: String
    let description: String?
    let isActionable: Bool
    let actionButtonTitle: String?
    let actionLink: String?
    let image: String?
    let caption: String?
    let isDismissable: Bool
    let children: [Any]
}

class FirstBottomSheet: UIView, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var demoCollectionView: UICollectionView!
    
    @IBOutlet weak var viewButton: UIButton!
    
    var nudges: [VCNudge] = [
        VCNudge(type: .default, title: "HDFC", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: ["HDFC debited RS 50", "HDFC credited RS 30"]),
        VCNudge(type: .default, title: "ICICI", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: ["ICICI credited RS 150", "ICICI credited RS 100"]),
        VCNudge(type: .default, title: "AXIS", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: []),
        VCNudge(type: .default, title: "IDFC", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: ["HDFC debited RS 50", "HDFC credited RS 30"]),
        VCNudge(type: .default, title: "SBI", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: ["ICICI credited RS 150", "ICICI credited RS 100"]),
        VCNudge(type: .default, title: "FINCARE", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: [])
    ]
    
    
    var selectedNudge: VCNudge?
    
    private var panGesture: UIPanGestureRecognizer!
    
    var currentHeight: CGFloat = 300
    let maxHeight: CGFloat = UIScreen.main.bounds.height * 2 / 4
    
    var currentCollectionViewIndex: Int = 0
    var isOpenBottomsheet: Bool = false
    
    private var dotStackView: UIStackView!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadViewFromXib()
        
        addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: currentHeight)
        contentView.autoresizingMask = [.flexibleWidth]
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        // Configure shadow properties
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.7
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 5
        contentView.layer.masksToBounds = false
        
        // CollectionView setup
        demoCollectionView.register(DemoCollectionViewCell.nib(), forCellWithReuseIdentifier: DemoCollectionViewCell.identifier)
        demoCollectionView.delegate = self
        demoCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        demoCollectionView.collectionViewLayout = layout
        
        // TableView setup
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DemoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Initially hide the table view
        tableView.isHidden = true
        self.shouldHideTransactionBtn(isHidden: nudges[currentCollectionViewIndex].children.isEmpty)
        
        //dot indecatior
        setupDotIndicators()
        
    }
    
    @IBAction func tapOnViewButton(_ sender: UIButton) {
        swipeUpBottomSheet()
    }
    
    
    private func loadViewFromXib() {
        let nib = UINib(nibName: "FirstBottomSheet", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Could not load view from nib")
        }
        contentView = view
    }
    
    
    private func swipeUpBottomSheet(){
        print("Opening Bottom Sheet")
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.size.height = self.maxHeight
            self.contentView.frame.origin.y = self.bounds.height - self.maxHeight
            self.tableView.isHidden = false
            self.viewButton.isHidden = true
        }, completion: { _ in
            self.currentHeight = 300
            self.isOpenBottomsheet = true
            
            // Update the selected nudge and reload data if applicable
            if self.currentCollectionViewIndex >= 0 && self.currentCollectionViewIndex < self.nudges.count {
                self.selectedNudge = self.nudges[self.currentCollectionViewIndex]
                self.tableView.reloadData()
            }
        })
        
    }
    
    private func swipeDownBottomSheet(){
        print("Closing Bottom Sheet")
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.size.height = 300
            self.contentView.frame.origin.y = self.bounds.height - 300
            self.tableView.isHidden = true
            //self.viewButton.isHidden = false
        }, completion: { _ in
            self.currentHeight = 300
            //self.isOpenBottomsheet = false
        })
    }
    
    
    // TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedNudge?.children.count ?? 0 // Use the selected nudge's children
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DemoTableViewCell.identifier, for: indexPath) as! DemoTableViewCell
        
        // Configure cell with the selected nudge's children
        if let child = selectedNudge?.children[indexPath.row] as? String { // Adjust type as necessary
            cell.myLabel.text = child
            cell.myImageView.backgroundColor = .yellow
        }
        
        return cell
    }
    
    
    
    // Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nudges.count // Return the number of nudges
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = demoCollectionView.dequeueReusableCell(withReuseIdentifier: DemoCollectionViewCell.identifier, for: indexPath) as! DemoCollectionViewCell
        
        let nudge = nudges[indexPath.row]
        cell.configure(with: nudge.title, designation: nudge.description ?? "")
        
        currentCollectionViewIndex = indexPath.row
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == demoCollectionView else { return }

        let offset = scrollView.contentOffset.x
        let width = scrollView.frame.size.width

        let currentIndex = Int(round(offset / width))

        currentCollectionViewIndex = currentIndex

        if currentIndex >= 0 && currentIndex < nudges.count {
            selectedNudge = nudges[currentIndex]
            tableView.reloadData()

            // Update dot indicators
            updateDotIndicators(currentIndex: currentIndex)
        }

    
        self.shouldHideTransactionBtn(isHidden: self.nudges[currentIndex].children.isEmpty)
        
        //
        
        if self.isOpenBottomsheet {
            if self.nudges[currentIndex].children.isEmpty{
                swipeDownBottomSheet()
            }else{
                swipeUpBottomSheet()
            }
        }

    }

    private func updateDotIndicators(currentIndex: Int) {
        for (index, dot) in dotStackView.arrangedSubviews.enumerated() {
            dot.backgroundColor = (index == currentIndex) ? .cyan : .lightGray // Active dot color
        }
    }

    
    
    private func shouldHideTransactionBtn(isHidden: Bool){
        
        if isOpenBottomsheet{
            viewButton.isHidden = true
        }else{
            viewButton.isHidden = isHidden
        }
        
    }
    
    
    private func setupDotIndicators() {
        dotStackView = UIStackView()
        dotStackView.axis = .horizontal
        dotStackView.distribution = .fillEqually
        dotStackView.spacing = 8
        dotStackView.translatesAutoresizingMaskIntoConstraints = false

        // Create dot indicators
        for _ in 0..<nudges.count {
            let dot = UIView()
            dot.backgroundColor = .lightGray
            dot.layer.cornerRadius = 5 // Make it circular (5 is half of 10)
            dot.clipsToBounds = true
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.widthAnchor.constraint(equalToConstant: 10).isActive = true
            dot.heightAnchor.constraint(equalToConstant: 3).isActive = true
            dotStackView.addArrangedSubview(dot)
        }
        
        contentView.addSubview(dotStackView)
        
        NSLayoutConstraint.activate([
//            dotStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            dotStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dotStackView.widthAnchor.constraint(equalToConstant: 150), // Fixed width
            dotStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dotStackView.topAnchor.constraint(equalTo: demoCollectionView.bottomAnchor, constant: 10)
        ])
        
        updateDotIndicators(currentIndex: 0)
    }
}

extension FirstBottomSheet: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.x < 0 {
            guard scrollView == demoCollectionView else { return }
            
            let offset = scrollView.contentOffset.x
            let width = scrollView.frame.size.width
            
            let indexToGoTo = Int(round(offset / width)) - 1
            
            if indexToGoTo < self.nudges.count - 1 {
                if let frame = self.demoCollectionView.layoutAttributesForItem(at: IndexPath(item: indexToGoTo, section: 0))?.frame {
                    targetContentOffset.pointee = CGPoint(x: frame.origin.x, y: 0)
                }
                
            }
        }
    }
}


