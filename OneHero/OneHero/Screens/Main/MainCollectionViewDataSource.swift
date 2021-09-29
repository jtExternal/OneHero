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
        
        // TODO replace with real image
        
        if let imageUrl = data.thumbnail?.url {
            ImageServiceHelper().fetchImage(url: imageUrl) { image in
                cell.locationImageView.image = image
            }
        }

        cell.configure(title: data.name ?? "", characterImage: Assets.detail.getImage() ?? UIImage())
        cell.characterData = data
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //                store.dispatch(HomeScreenActions.HomeScreenAction.setSelectedCharacter(profile: data))
        //                store.dispatch(RoutingAction(destination: .aboutCharacter, transitionType: .push, animationType: .standard))
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellIdentifier", for: indexPath) as? CharacterCollectionViewCell else {
            return
        }
        
        store.dispatch(HomeScreenActions.HomeScreenAction.setSelectedCharacter(profile: cell.characterData))
        store.dispatch(RoutingAction(destination: .aboutCharacter, transitionType: .present, animationType: .standard))
        
        //        // 6
        //        selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        //        // 7
        //        selectedCellImageViewSnapshot = selectedCell?.locationImageView.snapshotView(afterScreenUpdates: false)
        //
        //        presentSecondViewController(with: DataManager.data[indexPath.row])
    }
}
