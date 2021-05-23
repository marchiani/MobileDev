//
//  MovieDetailsViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 07.05.2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    let coreDm = CoreDataManager()
    var isSpinnerSpin = false
    @IBOutlet weak var TitleLb: UILabel!
    @IBOutlet weak var YearLb: UILabel!
    @IBOutlet weak var GenreLb: UILabel!
    @IBOutlet weak var DirectorLb: UILabel!
    @IBOutlet weak var CountryLb: UILabel!
    @IBOutlet weak var CountryLable: UILabel!
    
    @IBOutlet weak var LanguageLable: UILabel!
    @IBOutlet weak var ActorsLables: UILabel!
    @IBOutlet weak var ProductionLb: UILabel!
    @IBOutlet weak var ReleasedLb: UILabel!
    @IBOutlet weak var AwardsLb: UILabel!
    @IBOutlet weak var RatingLb: UILabel!
    @IBOutlet weak var PlotLb: UILabel!
    
    @IBOutlet weak var imageViewLB: UIImageView!
    var imdbID: String?
    
    var movie: MovieCoreData?
    var movieDetatils: MovieDetailsCoreData?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imdbID = movie?.imdbID
        sendRequest()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if (self.movieDetatils != nil){
                self.TitleLb.text = self.movieDetatils?.title
                self.YearLb.text = self.movieDetatils?.year
                self.GenreLb.text = self.movieDetatils?.genre
                self.DirectorLb.text = self.movieDetatils?.director
                self.CountryLable.text = self.movieDetatils?.country
                self.ActorsLables.text = self.movieDetatils?.actors
                self.ProductionLb.text = self.movieDetatils?.production
                self.ReleasedLb.text = self.movieDetatils?.released
                self.AwardsLb.text = self.movieDetatils?.awards
                self.RatingLb.text = self.movieDetatils?.rated
                self.PlotLb.text = self.movieDetatils?.plot
                self.LanguageLable.text = self.movieDetatils?.language
                self.imageViewLB.load(stringUrl: self.movieDetatils?.poster! ?? "")
                
                customActivityIndicatory(self.view, startAnimate: false)
            }
        }
    }
    func sendRequest (){
        if(isSpinnerSpin == false)
        {
            customActivityIndicatory(self.view, startAnimate: true)
            self.isSpinnerSpin = true
        }
        URLSession.shared.dataTask(with: URL(string: "http://www.omdbapi.com/?apikey=7e9fe69e&i=\(imdbID!)")!, completionHandler: { data, respons, error  in

            guard let data = data, error == nil else {
                self.movieDetatils = self.coreDm.getMovieDetailsByID(imdbID: self.imdbID ?? "")
                print("Something went wrong")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(MovieData.self, from: data)
                self.movieDetatils = self.coreDm.saveMovieDetailsCoreData(movie: decodedData)
                
            } catch {
                print(error)
            }
            
        }).resume()
    }
    

}

