//
//  MasterViewController.swift
//  SocialSmilerStore
//
//  Created by Hais Deakin on 31/05/2017.
//  Copyright © 2017 socialsuperstore. All rights reserved.
//

import UIKit
import Smile

class MasterViewController: UICollectionViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Emoji]()
    var searchController: UISearchController?
    var searchResultsController: SearchResultsController?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = Theme.backgroundColor
        collectionView?.contentInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        
        if let resultsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultsViewController") as? SearchResultsController {
            let searchController = UISearchController(searchResultsController: resultsViewController)
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.dimsBackgroundDuringPresentation = true
            definesPresentationContext = true
            searchController.searchBar.placeholder = "Emoji Yo Self"
            self.navigationItem.titleView = searchController.searchBar
            self.searchController = searchController
            self.searchResultsController = resultsViewController
        }
        
        objects = Emoji.listEmoji()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    
    // MARK: - CollectionViewController
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "masterSmileCell", for: indexPath) as? MasterSmileCollectionViewCell
            else { return UICollectionViewCell() }
        
        let data: Emoji = objects[indexPath.row]
        
        cell.label.text = data
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return objects.count
        default:
            return 0
        }
    }
    
}

extension MasterViewController :  UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text, searchString.characters.count > 0 else { return }
            
        let lowercaseSearchString = searchString.lowercased()
        
        let matches = Array(Smile.emojiList.keys).filter { $0.hasPrefix(lowercaseSearchString) }
        
        searchResultsController?.results(fromAlias: matches)
        
    }
}


class MasterSmileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.white
        
        layer.cornerRadius = 10.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowRadius = 10.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
}

