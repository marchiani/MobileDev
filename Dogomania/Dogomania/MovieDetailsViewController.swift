//
//  MovieDetailsViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 07.05.2021.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    
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
    
    var movie: Movie?
    var movieDetatils: MovieDetails?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imdbID = movie?.imdbID
        do {
            if let bundlePath = Bundle.main.path(forResource: "MovieDetails/\(imdbID!)", ofType: "txt"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let decodedData = try JSONDecoder().decode(MovieDetails.self, from: jsonData)
                print(decodedData)
                movieDetatils = decodedData
                }
            } catch {
                print(error)
            }
        
        TitleLb.text = movieDetatils?.title
        YearLb.text = movieDetatils?.year
        GenreLb.text = movieDetatils?.genre
        DirectorLb.text = movieDetatils?.director
        CountryLable.text = movieDetatils?.country
        ActorsLables.text = movieDetatils?.actors
        ProductionLb.text = movieDetatils?.production
        ReleasedLb.text = movieDetatils?.released
        AwardsLb.text = movieDetatils?.awards
        RatingLb.text = movieDetatils?.rated
        PlotLb.text = movieDetatils?.plot
        LanguageLable.text = movieDetatils?.language
        imageViewLB.image = UIImage(named: "Posters/\( movieDetatils?.poster ?? "trash.png")")
    }
    

}
