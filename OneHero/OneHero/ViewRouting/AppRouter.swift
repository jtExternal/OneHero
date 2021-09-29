//
//  AppRouter.swift
//  One Hero
//
//  Created by Justin Trantham on 9/28/21.
//

import Foundation
import ReSwift

final class AppRouter {
    private let window: UIWindow
    private var currentState: RoutingState?
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        store.subscribe(self) {
            $0.select {
                $0.routingState
            }.skipRepeats()
        }
        start()
    }
    
    var rootViewController: UIViewController? {
        return window.rootViewController
    }
    
    var visibleNavigationController: UINavigationController? {
        return visibleViewController?.navigationController
    }
    
    var visibleViewController: UIViewController? {
        guard let rootViewController = self.rootViewController else { return nil }
        
        if let presentedVC = rootViewController.presentedViewController {
            return presentedVC
        }
        
        if let navi = rootViewController as? UINavigationController {
            return navi.visibleViewController
        }
        
        return rootViewController
    }
    
    fileprivate func start() {
        showMain()
        window.makeKeyAndVisible()
    }
    
    fileprivate func showMain() {
        navigationController.popToRootViewController(animated: false)
        navigationController.viewControllers.removeAll()
        window.rootViewController = RoutingDestination.home.getScreen()
    }
    
    fileprivate func replaceRoot(identifier: RoutingDestination, transitionType _: SceneTransitionType, animationType: AnimationType = .standard, navigationBarHidden: Bool = false) {
        guard identifier.id != RoutingDestination.home.id else {
            showMain()
            return
        }
        
        guard shouldAdd(routingId: identifier) else {
            Log.e("ERROR: Screen already showing \(identifier.id)")
            return
        }
        
        guard let viewController = identifier.getScreen() else {
            Log.e("Unable to initialize viewcontroller with id \(identifier.id)")
            return
        }
        
        Log.i("Replacing root view controller with \(identifier.id) ")
        
        switch animationType {
        case .flip:
            if let currentView = self.rootViewController?.view {
                let flipTransition: OneHeroTransition = FlipTransition()
                flipTransition.animateFlipTransition(fromView: currentView, toView: viewController.view) { [weak self] in
                    
                    DispatchQueue.main.async {
                        [weak self] in
                        self?.navigationController.viewControllers.removeAll()
                        self?.window.rootViewController = nil
                        self?.navigationController.setViewControllers([viewController], animated: false)
                        self?.navigationController.isNavigationBarHidden = true
                        self?.window.rootViewController = self?.navigationController
                        self?.window.makeKeyAndVisible()
                    }
                }
            }
        case .standard:
            navigationController.popToRootViewController(animated: false)
            navigationController.isNavigationBarHidden = navigationBarHidden
            navigationController.setViewControllers([viewController], animated: true)
            window.rootViewController = navigationController
        case .slide:
            Log.w("Slide animation not implemented for replacing controller.s")
        case .none:
            Log.w("None animation not implemented for replacing controller.s. None is used for designating no animation on transition")
        }
    }
    
    fileprivate func pushViewController(identifier: RoutingDestination, transitionType: SceneTransitionType, animated: Bool = true, navigationBarHidden _: Bool = false) {
        guard let viewController = identifier.getScreen() else {
            Log.e("ERROR: Unable to get screen \(identifier.id)")
            return
        }
        
        guard shouldAdd(routingId: identifier) else {
            Log.e("ERROR: Screen already showing \(identifier.id)")
            return
        }
        
        switch transitionType {
        case .push:
            if let nav = visibleNavigationController {
                nav.pushViewController(viewController, animated: animated)
            }
        case let .pushUsing(nav):
            if let nav = nav {
                nav.pushViewController(viewController, animated: animated)
            }
        case .root:
            replaceRoot(identifier: identifier, transitionType: transitionType)
        default:
            Log.e("Pushing view controller unhandled case. \(transitionType)")
        }
        
        window.makeKeyAndVisible()
    }
    
    fileprivate func present(scene: RoutingDestination) {
        guard let viewController = scene.getScreen() else {
            Log.e("Unable to initialize viewcontroller with id \(scene)")
            return
        }
        
        if let vc = viewController as? AboutCharacterViewController {
            vc.modalPresentationStyle = .fullScreen
            rootViewController?.present(vc, animated: true, completion: nil)
        } else {
            navigationController.topViewController?.present(viewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func shouldAdd(routingId: RoutingDestination) -> Bool {
        let viewController = routingId.getScreen()
        let newViewControllerType = type(of: viewController)
        let navigationCtrl: UINavigationController = navigationController
        
        // check to see if the current rootview controller is what we want to show
        guard type(of: window.rootViewController) == newViewControllerType else {
            return false
        }
        
        // check to see if the navigation stack has what we want to show
        if let windowNav = window.rootViewController as? UINavigationController {
            if let currentVc = windowNav.topViewController {
                let currentViewControllerType = type(of: currentVc)
                if currentViewControllerType == newViewControllerType {
                    return false
                }
            }
        }
        
        if let currentVc = navigationCtrl.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == newViewControllerType {
                return false
            }
        }
        
        return true
    }
}

// MARK: - StoreSubscriber
extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        store.dispatch(SetCurrentViewAction(currentView: state.currentViewId))
        
        DispatchQueue.main.async { [weak self] in
            self?.performTransition(to: state.navigationState, transitionType: state.transitionType, with: state.animationType)
        }
    }
    
    func performTransition(to scene: RoutingDestination, transitionType: SceneTransitionType, with animationType: AnimationType = .standard) {
        let shouldAnimate = (animationType != .none) && (transitionType != .pushWithoutAnimation)
        
        switch transitionType {
        case .launching:
            start()
        case .push, .pushUsing:
            pushViewController(identifier: scene, transitionType: transitionType, animated: shouldAnimate)
        case .pushWithoutAnimation:
            pushViewController(identifier: scene, transitionType: .push, animated: shouldAnimate)
        case .show:
            Log.w("Show not implemented!")
        case .root:
            replaceRoot(identifier: scene, transitionType: transitionType, animationType: animationType)
        case .present, .alert:
            Log.w(".alert & .present not implemented!")
            break
        case .back:
            navigationController.popViewController(animated: shouldAnimate)
        case .backUsing:
            navigationController.popViewController(animated: shouldAnimate)
        case .popToRoot:
            navigationController.popToRootViewController(animated: shouldAnimate)
        case .none: break
        }
    }
}
