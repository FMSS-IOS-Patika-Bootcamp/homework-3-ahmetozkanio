//
//  PhotosViewController.swift
//  PatikaFmssHomework-3-ahmetozkan
//
//  Created by Ahmet Ozkan on 21.09.2022.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let photosViewModel = PhotosViewModel()
    private var items: [PhotosCellViewModel] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupUI()
        photosViewModel.viewDelegate = self
        photosViewModel.didViewLoad()
    
    }
}

private extension PhotosViewController{
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    func registerCell(){
        
        collectionView.register(.init(nibName: "PhotosViewCollectionViewCell",bundle:nil),forCellWithReuseIdentifier: "PhotosViewCollectionViewCell")
    }
}

extension PhotosViewController: PhotosViewModelViewProtocol{
    //
    func didCellItemFetch(_ items: [PhotosCellViewModel]) {
        self.items = items
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension PhotosViewController: UICollectionViewDelegate{
    
}
extension PhotosViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosViewCollectionViewCell", for: indexPath) as? PhotosViewCollectionViewCell
        
        //Here kingfisher is used and photos are sent to CollectionViewCell
        
        cell?.imageView.kf.setImage(with: URL(string: items[indexPath.row].image))
        
        return cell!
    }
    
    
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.2  , height: collectionView.frame.width * 0.2 )
        
    }

}
