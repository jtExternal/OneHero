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
    var marvelCharacterData:MarvelCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let cross = #imageLiteral(resourceName: "cross").withRenderingMode(.alwaysTemplate)
//        closeButton.setImage(cross, for: .normal)
//        closeButton.tintColor = .white
//
//        headerCharacterImageView.image = data.image
//        titleText.text = data.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        store.subscribe(self) {
            $0.select {
                $0.userProfileState
            }
        }

//        if !isMovingToParent {
//            store.dispatch(UserProfileActionCreators().fetchUserProfile)
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    @IBAction func close(_ sender: Any) {
        // TODO dispatch close
        dismiss(animated: true)
    }

}

extension AboutCharacterViewController: StoreSubscriber {
    func newState(state: AboutCharacterProfileState) {
        if marvelCharacterData == nil {
            marvelCharacterData = state.userProfile
        }
        
        if let populatedData = marvelCharacterData {
            DispatchQueue.main.async { [weak self] in
                
                if let imageUrl = populatedData.thumbnail?.url {
                    
                    ImageServiceHelper().fetchImage(url:imageUrl) { image in
                        self?.headerCharacterImageView.image = image
                    }
                }
               
                self?.titleText.text = populatedData.name
                self?.textView.text = populatedData.description
            }
        }
    }
}
