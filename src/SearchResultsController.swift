//
//  SearchResultsController.swift
//  SocialSmileyStore
//
//  Created by Hais Deakin on 31/05/2017.
//
//

import Foundation
import UIKit
import Smile

typealias EmojiSearchResult = (emoji: Emoji, name: String)

class SearchResultsController: UITableViewController {
    
    var results = [EmojiSearchResult]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.tableFooterView = UIView()
        tableView.backgroundColor = Theme.backgroundColor.withAlphaComponent(0.3)
    }
    
    func results(fromAlias names: [String]) {
        results = names.map { (emoji: Smile.emoji(alias: $0) ?? "", name: $0.aliasToName()) }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
        case 0: return results.count
        default: return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell") as? SearchResultTableViewCell else { return UITableViewCell() }
        
        let result = results[indexPath.row]
        
        cell.resultLabel.text = "\(result.emoji) \(result.name)"
        
        return cell
        
    }
    
}

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resultLabel: UILabel!
}

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    func aliasToName() -> String {
        return characters.split{$0 == "_"}.map(String.init).map { $0.capitalizingFirstLetter() }.joined(separator: " ")
    }
}
