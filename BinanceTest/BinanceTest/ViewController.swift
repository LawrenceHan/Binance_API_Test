//
//  ViewController.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/6.
//  Copyright © 2018 hanguang. All rights reserved.
//

import UIKit
import POPAPIKit
import ActionStageSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CellConfigurable, LHWWatcher {
    
    // MARK: - Types
    
    // MARK: - Properties
    
    /// Data model for the table view.
    var products = [ProductData]()
    var filteredData: [[ProductData]] = [[], [],  [], []]
    
    /** The following 2 properties are set in viewDidLoad(),
     They are implicitly unwrapped optionals because they are used in many other places
     throughout this view controller.
     */
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    /// Secondary search results table view.
    var resultsTableController: ResultsTableController!
    
    var segmentedControl: XMSegmentedControl!
    var tableView: UITableView!
    var actionHandler: LHWHandler?
    var isFirstLoad: Bool = true
    var currentIndex: Int = 0
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(hex: 0x15161C)!
        let title = UILabel()
        title.text = "Markets"
        title.textColor = UIColor(hex: 0xA7A9AC)
        title.font = UIFont.systemFont(ofSize: 16)
        navigationItem.titleView = title
        
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x232830)!
        navigationController?.navigationBar.tintColor = UIColor(hex: 0x9A9DA3)!
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backgroundColor = UIColor(hex: 0x232830)!
        let highlightColor = UIColor(hex: 0xC3B389)!
        let titles = ["BNB", "BTC", "ETH", "USDT"]
        
        segmentedControl = XMSegmentedControl(frame: CGRect.zero, segmentTitle: titles, selectedItemHighlightStyle: .bottomEdge)
        segmentedControl.backgroundColor = backgroundColor
        segmentedControl.highlightColor = highlightColor
        segmentedControl.tint = UIColor(hex: 0xEBF0F5)!
        segmentedControl.highlightTint = highlightColor
        segmentedControl.autoresizingMask = .flexibleWidth
        segmentedControl.delegate = self;
        
        view.addSubview(segmentedControl)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(activeSearch))
        
        tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hex: 0x1D1F24)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductDataCell.self)
        tableView.backgroundColor = UIColor(hex: 0x15161C)!
        tableView.allowsSelection = false
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.indicatorStyle = .white
        
        tableView.addPullToRefresh(PullToRefresh()) { [weak self] in
            guard let `self` = self else { return }
            
            guard !self.searchController.isActive else { return }
            
            self.reloadAllData()
        }
        
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        segmentedControl.frame = CGRect(
            x: 0,
            y: view.safeTopValue,
            width: view.bounds.width,
            height: 50
        )
        
        var offset: CGFloat = 50.0
        if searchController.isActive {
            if iPhoneX() {
                offset = view.safeTopValue-searchController.searchBar.frame.size.height
            } else {
                offset = searchController.searchBar.frame.size.height-50;
            }
        }
        
        tableView.frame = CGRect(
            x: 0,
            y: offset,
            width: view.bounds.width,
            height: view.bounds.height-offset-view.safeBottomValue
        )
        
        if iPhoneX() {
            offset = 52
        } else {
            offset = 64;
        }
        
        resultsTableController.tableView.frame = CGRect(
            x: 0,
            y: -offset,
            width: resultsTableController.tableView.bounds.width,
            height: resultsTableController.tableView.bounds.height+offset
        )
    }
    
    deinit {
        actionHandler?.reset()
        Actor.removeWatcher(self)
        tableView.removeAllPullToRefresh()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Actor Model
        actionHandler = LHWHandler(delegate: self)
        Actor.watchForPath("/exchange/public/product", watcher: self)
        
        resultsTableController = ResultsTableController()
        
        /*
         We want ourselves to be the delegate for this filtered table so
         didSelectRowAtIndexPath(_:) is called for both tables.
         */
        resultsTableController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        
        if #available(iOS 11.0, *) {
            // For iOS 11 and later, we place the search bar in the navigation bar.
//            navigationController?.navigationBar.prefersLargeTitles = true
            
            // We want the search bar visible all the time.
            navigationItem.hidesSearchBarWhenScrolling = false
        }
//        searchController.searchBar.searchBarStyle = .minimal
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false // default is YES
        searchController.searchBar.delegate = self    // so we can monitor text changes + others
        searchController.searchBar.barStyle = .black
        
        /*
         Search is now just presenting a view controller. As such, normal view controller
         presentation semantics apply. Namely that presentation will walk up the view controller
         hierarchy until it finds the root view controller or one that defines a presentation context.
         */
        definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isFirstLoad {
            reloadAllData()
            isFirstLoad = false
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension ViewController {
    @objc func activeSearch() {
        if !products.isEmpty {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        tableView.topPullToRefresh?.isEnabled = false
        segmentedControl.isHidden = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.isActive = true
    }
    
    func reloadAllData() {
        Actor.requestActor(path: "/exchange/public/product", watcher: self)
    }
}

// MARK: - Actor Watcher

extension ViewController {
    func actorCompleted(status: LHWActionStageStatus, path: String, result: Any?) {
        print("\(path) is done")
    }
    
    func actionStageResourceDispatched(path: String, resource: Any?, arguments: Any?) {
        if path == "/exchange/public/product" {
            LHWDispatchOnMainThread { [unowned self] in
                if let result = resource as? [[ProductData]] {
                    self.filteredData = result
                    if !self.products.isEmpty {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                    self.products = self.filteredData[self.currentIndex]
                    self.tableView.reloadData()
                }
                self.tableView.endRefreshing(at: .top)
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Protocol Oriented Programming 🤟🤟🤟
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ProductDataCell
        
        let product = products[indexPath.row]
        configureCell(cell, forProduct: product)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct: ProductData
        
        // Check to see which table view cell was selected.
        if tableView === self.tableView {
            selectedProduct = products[indexPath.row]
        } else {
            selectedProduct = resultsTableController.filteredProducts[indexPath.row]
        }
        
        // Set up the detail view controller to show.
        //        let detailViewController = DetailViewController.detailViewControllerForProduct(selectedProduct)
        //        navigationController?.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.topPullToRefresh?.isEnabled = true
        segmentedControl.isHidden = false
        tableView.tableHeaderView = nil
    }
    
}

// MARK: - UISearchControllerDelegate

extension ViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
}

// MARK: - UISearchResultsUpdating

extension ViewController: UISearchResultsUpdating {
    
    func findMatches(searchString: String) -> NSCompoundPredicate {
        var searchItemsPredicate = [NSPredicate]()
        
        // Below we use NSExpression represent expressions in our predicates.
        // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value).
        
        // symbol field matching.
        let symbolExpression = NSExpression(forKeyPath: "symbol")
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        
        let symbolSearchComparisonPredicate =
            NSComparisonPredicate(leftExpression: symbolExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: .caseInsensitive)
        
        searchItemsPredicate.append(symbolSearchComparisonPredicate)
        
        // `volume` field matching.
        let volumeExpression = NSExpression(forKeyPath: "volume")
        let volumePredicate =
            NSComparisonPredicate(leftExpression: volumeExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .beginsWith,
                                  options: .caseInsensitive)
        
        searchItemsPredicate.append(volumePredicate)
        
        // `open` field matching.
        let openExpression = NSExpression(forKeyPath: "open")
        let openPredicate =
            NSComparisonPredicate(leftExpression: openExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .beginsWith,
                                  options: .caseInsensitive)
        
        searchItemsPredicate.append(openPredicate)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        numberFormatter.formatterBehavior = .default
        
        let targetNumber = numberFormatter.number(from: searchString)
        
        // `searchString` may fail to convert to a number.
        if targetNumber != nil {
            // Use `targetNumberExpression` in both the following predicates.
            let targetNumberExpression = NSExpression(forConstantValue: targetNumber!)
            
            // `tradedMoney` field matching.
            let lhs = NSExpression(forKeyPath: "tradedMoney")
            
            let tradedMoneyPredicate =
                NSComparisonPredicate(leftExpression: lhs,
                                      rightExpression: targetNumberExpression,
                                      modifier: .direct,
                                      type: .equalTo,
                                      options: .caseInsensitive)
            
            searchItemsPredicate.append(tradedMoneyPredicate)
        }
        
        // Add this OR predicate to our master AND predicate.
        let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates:searchItemsPredicate)
        
        return orMatchPredicate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Update the filtered array based on the search text.
        let searchResults = products
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Build all the "AND" expressions for each value in the searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            findMatches(searchString: searchString)
        }
        
        // Match up the fields of the Product object.
        let finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }
        
        // Hand over the filtered results to our search results table.
        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            resultsController.filteredProducts = filteredResults
            resultsController.tableView.reloadData()
        }
    }
    
}

extension ViewController: XMSegmentedControlDelegate {
    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
        currentIndex = selectedSegment
        guard !products.isEmpty else { return }
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        products = filteredData[currentIndex]
        tableView.reloadSections([0], with: .automatic)
    }
}

