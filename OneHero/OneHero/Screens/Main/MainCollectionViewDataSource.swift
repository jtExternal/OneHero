//
//  HomeViewTableViewDataSource.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import UIKit

class MainCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    fileprivate var marvelCharacters: [MarvelCharacter]?
    
    init(marvelCharacters: [MarvelCharacter]) {
        self.marvelCharacters = marvelCharacters
    }
    
    func getMarvelCharacters() -> [MarvelCharacter]? {
        return marvelCharacters
    }
    
    func addMore(list: [MarvelCharacter]) {
        marvelCharacters?.append(contentsOf: list)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marvelCharacters?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseId, for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.tag = indexPath.row
        
        guard let data = marvelCharacters?[indexPath.row] else {
            return cell
        }
        
        if let imageUrl = data.thumbnail?.url {
            ImageServiceHelper().fetchImage(url: imageUrl) { image in
                cell.locationImageView.image = image
            }
        }

        cell.configure(title: data.name ?? "", characterImage: Assets.detail.getImage() ?? UIImage())
        cell.characterData = data
        
        return cell
    }
}
