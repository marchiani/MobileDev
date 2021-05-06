//
//  ListViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 06.05.2021.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movies = Welcome()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.search.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.detailTextLabel?.text = movies.search[indexPath.row].title
        cell.textLabel?.text = "\(movies.search[indexPath.row].poster) type: \(movies.search[indexPath.row].type), year: \(movies.search[indexPath.row].year)"
        
        return cell
    }
    
    func downloadJson(completed: @escaping () -> ()) {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: "Movies",
                                                     ofType: "json"),
                    let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(Welcome.self,
                                                           from: jsonData)
                print(decodedData)
                movies = decodedData
                }
            } catch {
                print(error)
            }
        
    }

}
