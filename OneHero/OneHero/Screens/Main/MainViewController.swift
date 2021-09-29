//
//  ViewController.swift
//  OneHero
//
//  Created by Justin Trantham on 9/29/21.
//
import UIKit
import ReSwift

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private var loadingInit = false
    var selectedCell: CharacterCollectionViewCell?
    private var selectedCellImageViewSnapshot: UIView?
    private var animator: Animator?
    private var dataSource: MainCollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingInit = true
        hideKeyboard()
        
        dataSource = MainCollectionViewDataSource(marvelCharacters: [MarvelCharacter]())
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        setupRefreshControl()
        fetchNotifications(page: 0, shouldResetList: true)
        loadingInit = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) {
            $0.select {
                $0.homeScreenState
            }
        }
        
        navigationController?.navigationBar.apply(Stylesheet.Main.navBarAppearance)
        navigationItem.backBarButtonItem = Stylesheet.Main.navBarItemAppearance()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshList(_:)), for: .valueChanged)
    }
    
    @objc private func refreshList(_: Any) {
        fetchNotifications(page: 0, shouldResetList: true)
    }
    
    func hideRefreshControl() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func fetchNotifications(page: Int, shouldResetList: Bool = false) {
        if shouldResetList {
            store.dispatch(HomeScreenActions.HomeScreenAction.reset)
        }
        
        store.dispatch(HomeScreenActions.HomeScreenAction.setStartEndPagingIndex(pagingIndex: PagingIndex(start: page)))
        store.dispatch(HomeScreenActionCreators().getCharacters)
        
    }
    
    func setDataSource(marvelCharacters: [MarvelCharacter]) {
        dataSource = MainCollectionViewDataSource(marvelCharacters: marvelCharacters)
        
        DispatchQueue.main.async {
            [weak self] in
            self?.collectionView.dataSource = self?.dataSource
            self?.collectionView.reloadData()
        }
    }
    
    func presentExpandableInfo(marvelCharacter: MarvelCharacter) {
        if let aboutVc = RoutingDestination.aboutCharacter.getScreen() as? AboutCharacterViewController {
            aboutVc.transitioningDelegate = self
            aboutVc.modalPresentationStyle = .fullScreen
            aboutVc.marvelCharacterData = marvelCharacter
            
            present(aboutVc, animated: true) {
                store.dispatch(HomeScreenActions.HomeScreenAction.presentPopover(presentPopover: .none))
            }
        }
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseId, for: indexPath) as? CharacterCollectionViewCell else {
            return
        }
       
        guard let data =  dataSource?.getMarvelCharacters()?[indexPath.row] else {
            return
        }

        store.dispatch(HomeScreenActions.HomeScreenAction.setSelectedCharacter(profile: data))
        store.dispatch(UserProfileActions.UserProfileAction.setUserProfile(profile: data))
        store.dispatch(HomeScreenActions.HomeScreenAction.presentPopover(presentPopover: .present))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 10) / 2
        return .init(width: width, height: width)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let firstViewController = presenting as? MainViewController,
              let secondViewController = presented as? AboutCharacterViewController,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }
        
        animator = Animator(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let secondViewController = dismissed as? AboutCharacterViewController,
              let selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        else { return nil }
        
        animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
        return animator
    }
}

extension MainViewController: StoreSubscriber {
    func newState(state: HomeScreenState) {
        if state.presentPopover == .present {
            presentExpandableInfo(marvelCharacter: state.selectedCharacter ?? MarvelCharacter())
            return
        }
        
        switch state.retrievalState {
        case .failure:
            hideRefreshControl()
        case .fetched:
            if state.shouldLoadMore {
                if dataSource == nil {
                    setDataSource(marvelCharacters: state.characters)
                }
                dataSource?.addMore(list: state.characters)
                
            } else {
                setDataSource(marvelCharacters: state.characters)
            }
            
            DispatchQueue.main.async {
                [weak self] in
                self?.hideRefreshControl()
                self?.collectionView.reloadData()
            }
            
        case .fetching:
            break
        case .none:
            hideRefreshControl()
        case .queryPassed:
            break
        case .success:
            break
        case .notFetched:
            break
        }
    }
}
