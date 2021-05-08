//
//  ListViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 06.05.2021.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    
    var filteredMovies: [Movie]!
    
    @IBOutlet weak var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson {
            self.tableView.reloadData()
        }
        search.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: filteredMovies[indexPath.row].imdbID)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: filteredMovies[indexPath.row].imdbID)
        }
        
        
        cell!.textLabel?.text = filteredMovies[indexPath.row].title
        cell!.detailTextLabel?.text = "type: \(filteredMovies[indexPath.row].type), year: \(filteredMovies[indexPath.row].year)"
        cell!.imageView?.image = UIImage(named: "Posters/\( filteredMovies[indexPath.row].poster )")
        cell!.imageView?.contentMode = .scaleAspectFit
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailsViewController {
            destination.movie = filteredMovies[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJson(completed: @escaping () -> ()) {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: "Movies",
                                                     ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(Welcome.self,
                                                           from: jsonData)
                
                movies = decodedData.search
                filteredMovies = movies
                }
            } catch {
                print(error)
            }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = [Movie]()
        
        if searchText ==  "" {
            filteredMovies = movies
            self.tableView.reloadData()
            return;
        }
        for movie in movies {
            if movie.title.lowercased().contains(searchText.lowercased()){
                filteredMovies.append(movie)
            }
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [ delete ])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let movie = filteredMovies[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Delete") {
            (action, view, completion) in
            self.filteredMovies.remove(at: indexPath.row)
            self.movies.removeAll(where: { $0.imdbID == movie.imdbID })
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "trash.png")
        action.backgroundColor = .systemRed
        
        return action
    }
    
    @IBAction func didTapButtonAdd(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddMovie") as! AddMovieViewController
        vc.modalPresentationStyle = .fullScreen
        vc.completionHandler = { data in
            do {
                let jsonData = data!.data(using: .utf8)!
                
                let decodedData = try JSONDecoder().decode(Movie.self, from: jsonData)
                self.filteredMovies.append(decodedData)
                self.movies.append(decodedData)
                self.tableView.reloadData()
                } catch {
                    print(error)
                }
            
             }
        present(vc, animated: true)
    }
}
