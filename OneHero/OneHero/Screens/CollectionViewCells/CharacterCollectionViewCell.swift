//
//  CharacterCollectionViewCell.swift
//  One Hero
//
//  Created by Justin Trantham on 9/29/21.
//

import Foundation
import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    static let reuseId = "collectionViewCharacterCell"
    @IBOutlet private(set) var characterImageView: UIImageView!
    @IBOutlet private(set) var characterTitle: UILabel!
    var characterData:MarvelCharacter?
    
    private lazy var setupOnce: Void = {
        contentView.layer.cornerRadius = 12.0
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        characterTitle.apply(Stylesheet.Main.Labels.oneHeroTitleWhiteMedium18)
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        _ = setupOnce
    }
    
    func configure(title: String, characterImage: UIImage) {
        characterImageView.image = characterImage
        characterTitle.text = title
    }
}
