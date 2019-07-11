//
//  ViewController.swift
//  Recipes
//
//  Created by Leah Nella on 7/11/19.
//  Copyright © 2019 Leah Nella. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
    var results = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipes"
        let query = "http://www.recipepuppy.com/api/"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                if json["title"] == "Recipe Puppy" {
                    parse(json: json)
                    return
                }
            }
            loadError()
        }
    }
    
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let href = result["href"].stringValue
            let ingredients = result["ingredients"].stringValue
            let result = ["title": title, "href": href, "ingredients": ingredients]
            results.append(result)
        }
        tableView.reloadData()
    }
    
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the recipes feed",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.text = result["title"]
        cell.detailTextLabel?.text = result["ingredients"]
        print("OK")
        return cell
    }
}
