//
//  ListViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 06.05.2021.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource {

    let coreDm = CoreDataManager()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var searchText: String = ""
    
    var movies = [MovieCoreData]()
    var isSpinnerSpin = false
    
    @IBOutlet weak var search: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(coreDm.getAllMovieCoreDatas())
        self.spinner.hidesWhenStopped = true
        search.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        cell.titleLabel01?.text = movies[indexPath.row].title
        cell.textLabel02?.text = "type: \(String(describing: movies[indexPath.row].type)), year: \(String(describing: movies[indexPath.row].year))"
        if let data = try? Data(contentsOf: URL(string: self.movies[indexPath.row].poster!)!) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imageCell?.image = image
                    cell.imageCell?.contentMode = .scaleAspectFit
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailsViewController {
            destination.movie = movies[(self.tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJson(completed: @escaping () -> ()) {
        if(isSpinnerSpin == false)
        {
            customActivityIndicatory(self.view, startAnimate: true)
            self.isSpinnerSpin = true
        }
        URLSession.shared.dataTask(with: URL(string: "http://www.omdbapi.com/?apikey=7e9fe69e&s=\(self.searchText.replacingOccurrences(of: " ", with: ""))))'&page=1")!, completionHandler: { data, respons, error  in
            guard let data = data, error == nil else {
                self.movies = self.coreDm.getAllMovieCoreDatas()
                print("Something went wrong")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
                // Just for example that I have spinner
                if (self.isSpinnerSpin) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isSpinnerSpin = false
                        self.movies = self.coreDm.saveMoviesCoreData(movies: decodedData.search)
                        customActivityIndicatory(self.view, startAnimate: false)
                    }
                }
            } catch {
                if (self.isSpinnerSpin) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isSpinnerSpin = false
                        self.movies = []
                        customActivityIndicatory(self.view, startAnimate: false)
                    }
                }
                print(error)
            }
            
        }).resume()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.count < 3) {
            self.movies.removeAll()
            self.tableView.reloadData()
            return;
        }
        self.searchText = searchText
        downloadJson {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [ delete ])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Delete") {
            (action, view, completion) in
            self.movies.remove(at: indexPath.row)
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
                
                self.movies.append(self.coreDm.saveMovieCoreData(movie: decodedData))
                self.tableView.reloadData()
                } catch {
                    print(error)
                }
            
             }
        present(vc, animated: true)
    }
}

extension UIImageView {
    func load(stringUrl: String) {
        guard let url = URL(string: stringUrl) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

@discardableResult
func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
      let mainContainer: UIView = UIView(frame: viewContainer.frame)
      mainContainer.center = viewContainer.center
      mainContainer.backgroundColor = hexStringToUIColor(hex: "0xFFFFFF")
      mainContainer.alpha = 0.5
      mainContainer.tag = 789456123
      mainContainer.isUserInteractionEnabled = false
  
      let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
      viewBackgroundLoading.center = viewContainer.center
    viewBackgroundLoading.backgroundColor = hexStringToUIColor(hex: "0x444444")
      viewBackgroundLoading.alpha = 0.5
      viewBackgroundLoading.clipsToBounds = true
      viewBackgroundLoading.layer.cornerRadius = 15
  
      let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
      activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
    activityIndicatorView.style =
        UIActivityIndicatorView.Style.whiteLarge
      activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
              if startAnimate!{
                   viewBackgroundLoading.addSubview(activityIndicatorView)
                    mainContainer.addSubview(viewBackgroundLoading)
                    viewContainer.addSubview(mainContainer)
                    activityIndicatorView.startAnimating()
              }else{
                     for subview in viewContainer.subviews{
                          if subview.tag == 789456123{
                            subview.removeFromSuperview()
                          }
                      }
              }
         return activityIndicatorView
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
