//
//  AddMovieViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 08.05.2021.
//

import UIKit

class AddMovieViewController: UIViewController {

    @IBOutlet weak var TitleField: UITextField!
    @IBOutlet weak var TypeFIeld: UITextField!
    @IBOutlet weak var YearField: UITextField!
    public var completionHandler: ((String?) -> Void)?
    
    @IBAction func SaveAction(_ sender: Any) {
        let data = String("""
{"Title":"\(TitleField.text!)","Year":"\(YearField.text!)","imdbID":"Random","Type":"\(TypeFIeld.text!)","Poster":"Poster_01.jpg"}
""")
        completionHandler?(data)
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
