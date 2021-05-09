//
//  ImagesViewController.swift
//  Dogomania
//
//  Created by SWAN mac on 08.05.2021.
//

import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [UIImage] = []
    var isSpinnerSpin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: "MyCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        downloadImages()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if (self.images.count == 18 && self.isSpinnerSpin == true){
                customActivityIndicatory(self.view, startAnimate: false)
                self.isSpinnerSpin = false
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func didTapButton(_ sender: Any) {
         let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        self.collectionView.reloadData()
    }
    
    func downloadImages() {
        if(isSpinnerSpin == false)
        {
            customActivityIndicatory(self.view, startAnimate: true)
            self.isSpinnerSpin = true
        }
        
        URLSession.shared.dataTask(with: URL(string: "https://pixabay.com/api/?key=19193969-87191e5db266905fe8936d565&q=small+animals&image_type=photo&per_page=18")!, completionHandler: { data, respons, error  in
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(Image.self, from: data)
                for item in decodedData.hits{
                    let url = URL(string: item.webformatURL)
                    DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: url!) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.images.append(image)
                                }
                            }
                        }
                    }
                }
                
            } catch {
                print(error)
            }
            
        }).resume()
    }
}

extension ImagesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            self.images.append(image)
            self.collectionView.reloadData()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension ImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count: Int = Int(ceil(Double(self.images.count) / 6))
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        var localImages: [UIImage] = []
        let startArray: Int = indexPath.row * 6
        if (startArray < self.images.count){
            for index in startArray...self.images.count-1 {
                localImages.append(self.images[index])
            }
        }
        
        cell.configure(with: localImages)
        
        return cell
    }
    
    
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize : CGRect = UIScreen.main.bounds
        return CGSize(width: screenSize.width, height:  screenSize.width)
    }
    
}
