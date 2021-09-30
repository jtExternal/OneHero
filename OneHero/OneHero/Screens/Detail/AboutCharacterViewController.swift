//
//  AboutCharacterViewController.swift
//  One Hero
//
//  Created by Justin Trantham on 9/27/21.
//

import Foundation
import UIKit
import ReSwift

class AboutCharacterViewController: UIViewController {
    @IBOutlet weak var headerCharacterImageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    @IBOutlet weak var comicsButton: UIButton!
    @IBOutlet weak var learnMoreButton: UIButton!
    var marvelCharacterData:MarvelCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wikiButton.tag = 10
        self.comicsButton.tag = 11
        self.learnMoreButton.tag = 12
        
        wikiButton.addTarget(self, action: #selector(buttonGroupSelected), for: .touchUpInside)
        comicsButton.addTarget(self, action: #selector(buttonGroupSelected), for: .touchUpInside)
        learnMoreButton.addTarget(self, action: #selector(buttonGroupSelected), for: .touchUpInside)
        
        if marvelCharacterData?.getUrlType(destType: .wiki) == nil {
            self.wikiButton.isHidden = true
        }
        
        if marvelCharacterData?.getUrlType(destType: .comiclink) == nil {
            self.comicsButton.isHidden = true
        }
        
        if marvelCharacterData?.getUrlType(destType: .detail) == nil {
            self.learnMoreButton.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                $0.marvelCharacterProfileState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    @IBAction func close(_ sender: Any) {
        // TODO dispatch close
        dismiss(animated: true)
    }
    
    
    @objc func buttonGroupSelected(sender: UIButton!) {
        let wikiUrl = marvelCharacterData?.getUrlType(destType: .wiki)
        let comicUrl = marvelCharacterData?.getUrlType(destType: .comiclink)
        let detailUrl = marvelCharacterData?.getUrlType(destType: .detail)
        
        var selectedUrl:String? = nil
        
        switch sender.tag {
        case 10:
            selectedUrl = wikiUrl
        case 11:
            selectedUrl = comicUrl
        case 12:
            selectedUrl = detailUrl
        default:
            break
        }
        
        if let selectedUrlString = selectedUrl, let url = URL(string: selectedUrlString) {
            UIApplication.shared.open(url)
        }
    }
    
}

extension AboutCharacterViewController: StoreSubscriber {
    func newState(state: AboutCharacterProfileState) {
        if marvelCharacterData == nil {
            marvelCharacterData = state.userProfile
        }
        
        if let populatedData = marvelCharacterData {
            DispatchQueue.main.async { [weak self] in
                self?.textView.apply(Stylesheet.Main.TextViews.oneHeroMultiLineTextInput)
                
                if let imageUrl = populatedData.thumbnail?.url {
                    ImageServiceHelper().fetchImage(url:imageUrl) { image in
                        self?.headerCharacterImageView.image = image
                    }
                }
                
                self?.titleText.text = populatedData.name
                
                if populatedData.description == nil || populatedData.description?.isEmpty ?? false {
                    self?.textView.attributedText = Assets.marvelHistoryBioPlaceholder.getRTF()
                } else {
                    self?.textView.text = populatedData.description
                }
                
            }
        }
    }
}
