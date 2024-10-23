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

//class FirstBottomSheet: UIView, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    @IBOutlet var contentView: UIView!
//    @IBOutlet weak var tableView: UITableView!
//    
//    @IBOutlet weak var demoCollectionView: UICollectionView!
//    let pageControl = UIPageControl()
//    
//    let myData:[String] = []//["first", "second", "first", "second", "first", "second"]
//    let collectionData = [("Subhrajit deb", "Software Developer"), ("Jay Sarder", "Client success")]
//    private var panGesture: UIPanGestureRecognizer!
//    
//    var currentHeight: CGFloat = 300
//    let maxHeight: CGFloat = UIScreen.main.bounds.height * 2 / 3 // Two-thirds of the screen height
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//
//    private func commonInit() {
//        loadViewFromXib()
//        
//        addSubview(contentView)
//        contentView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: currentHeight)
//        contentView.autoresizingMask = [.flexibleWidth]
//        contentView.layer.cornerRadius = 20
//        contentView.clipsToBounds = true
//        
//        // Configure shadow properties
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.7
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        contentView.layer.shadowRadius = 5
//        contentView.layer.masksToBounds = false
//        
//        //Collectionview setup
//        demoCollectionView.register(DemoCollectionViewCell.nib(), forCellWithReuseIdentifier: DemoCollectionViewCell.identifier)
//        demoCollectionView.delegate = self
//        demoCollectionView.dataSource = self
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        demoCollectionView.collectionViewLayout = layout
//
//        
//        // TableView setup
//        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: DemoTableViewCell.identifier)
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        // Add pan gesture
//        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        contentView.addGestureRecognizer(panGesture)
//    }
//
//    private func loadViewFromXib() {
//        let nib = UINib(nibName: "FirstBottomSheet", bundle: nil)
//        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
//            fatalError("Could not load view from nib")
//        }
//        contentView = view
//    }
//
//
//    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
//        let translation = gesture.translation(in: self)
//
//        print("print...")
//        switch gesture.state {
//        case .changed:
//            let newHeight = currentHeight - translation.y
//            // Limit the height to maxHeight (two-thirds of screen) and minHeight (300)
//            if newHeight >= 300 && newHeight <= maxHeight {
//                contentView.frame.size.height = newHeight
//                currentHeight = newHeight // Update currentHeight
//                contentView.frame.origin.y = self.bounds.height - newHeight
//            }
//            print("top here...")
//        case .ended, .cancelled:
//            print("down here...")
//
//            let velocity = gesture.velocity(in: self)
//            if velocity.y < 0 {
//                // If swiping up
//                print("clicked 1")
//
//                UIView.animate(withDuration: 0.3, animations:{
//                    self.contentView.frame.size.height = self.maxHeight
//                    self.contentView.frame.origin.y = self.bounds.height - self.maxHeight
//                }, completion: { _ in
//                    self.currentHeight = 300
//                })
//                
//
//            } else {
//                // If swiping down
//                print("clicked 2")
//                UIView.animate(withDuration: 0.3) {
//                    self.contentView.frame.size.height = 300
//                    self.contentView.frame.origin.y = self.bounds.height - 300
//                }
//                currentHeight = 300 // Ensure currentHeight reflects the minimum height
//                // Close bottom sheet logic here (can be hooked to MainViewController)
//            }
//        default:
//            break
//        }
//    }
//
//    // TableView Delegates
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: DemoTableViewCell.identifier, for: indexPath) as! DemoTableViewCell
//        
//        cell.myLabel.text = myData[indexPath.row]
//        cell.myImageView.backgroundColor = .yellow
//        
//        return cell
//    }
//    
//    // Collection View Delegates
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        demoCollectionView.deselectItem(at: indexPath, animated: true)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return collectionData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = demoCollectionView.dequeueReusableCell(withReuseIdentifier: DemoCollectionViewCell.identifier, for: indexPath) as! DemoCollectionViewCell
//        
//        let (name, designation) = collectionData[indexPath.row]
//        cell.configure(with: name, designation: designation)
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: 100)
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
    let children: [Any] // Define the specific type if possible
}

class FirstBottomSheet: UIView, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var demoCollectionView: UICollectionView!
    
    @IBOutlet weak var viewButton: UIButton!
    
        
    var nudges: [VCNudge] = [
        VCNudge(type: .default, title: "HDFC", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: ["HDFC debited RS 50", "HDFC credited RS 30"]),
        VCNudge(type: .default, title: "ICICI", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: ["ICICI credited RS 150", "ICICI credited RS 100"]),
        VCNudge(type: .default, title: "AXIS", description: "Check record", isActionable: false, actionButtonTitle: "view", actionLink: "", image: "", caption: "test", isDismissable: false, children: [])
    ]
    
    
    var selectedNudge: VCNudge?

    private var panGesture: UIPanGestureRecognizer!
    
    var currentHeight: CGFloat = 300
    let maxHeight: CGFloat = UIScreen.main.bounds.height * 2 / 4
    
    var currentCollectionViewIndex: Int = 0
    
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
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame.size.height = self.maxHeight
            self.contentView.frame.origin.y = self.bounds.height - self.maxHeight
        }
        currentHeight = 300
        
        tableView.isHidden = false
        
        print("current idex \(currentCollectionViewIndex)")
        
        if currentCollectionViewIndex >= 0 && currentCollectionViewIndex < nudges.count {
            selectedNudge = nudges[currentCollectionViewIndex]
            tableView.reloadData()
        }
    }
    
    private func swipeDownBottomSheet(){
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame.size.height = 300
            self.contentView.frame.origin.y = self.bounds.height - 300
        }
        currentHeight = 300
        
        tableView.isHidden = true
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
        }
    
        self.shouldHideTransactionBtn(isHidden: self.nudges[currentIndex].children.isEmpty)
    }
    
    
    private func shouldHideTransactionBtn(isHidden: Bool){
        viewButton.isHidden = isHidden
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


