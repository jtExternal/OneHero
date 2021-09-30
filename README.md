# One Hero

Mobile iOS solution to allow users to easily browse and learn about characters from the Marvel Universe! 


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- Xcode 13
- iOS 14.7+


### Installation

1. Clone project. Project clone instructions can be found within the Github project and then the repo named 'OneHero'

2. Run Cocoapods Also, Remember to perform a pod update to check for latest version of the repos like once a week. The CI server will perform a pod update on every build

Currently the project uses the following pods:

Run the following once project is cloned

### Installation

- Infinite scrolling while loading superheroes
- Detailed information about a character upon selection
- Cached images and json for easy offline browsing


## Generate App Secrets

The project doesn't and shouldn't store any secure/private credentials outside of a developers machine or CI machine. So, during there is a build phase script that will set environment variables based upon build scheme. If you change the build scheme, file, folder names then this will cause the build phase script to not be able to find the scripts. BE Sure to remember to update names in all places (~/Example, ~/Actual, generate+)

1. Navigate to Configurations/Secrets/Example to view example environment variable set scripts

2. Make a clone of this folder within Configurations/Secrets. Name the newly created folder "Actual". Remove '.example' from files. These script file names are used within the build phase named 'Generate App Secrets'.

3. Update the '

  <valid_id>' default value with correct value</valid_id>

4. Once the environment variable set scripts are correct you should be good to build the project. After building the project there should be a file name 'AppSecrets.swift' that was added within the ~/Secrets folder.

5. Add AppSecrets.swift as a reference to the project under Configurations/Secrets

6. You should now be able to use any of the properties within the generated file in the project.

Adding a new secret:

1. Navigate to Configurations/Secrets/Example & Actual and add your new key/value pair

2. Navigate to scripts/generate_secrets.rb and add your new key/value pair. Make sure you use the same KEY as in the environment variable set scripts.

3. Build project and you should the generated file update properly

Make sure you DONT commit any of these files. The only files permissible are the .example and these should contain blank values for the key/value pairs.

### Logging

```
Log.d("Navigation state updated") where 'd' can be either e,i,d,v,w,s depending on message level
```

### Custom Views, Styling & Colors

Project has a Theme folder that contains all of the custom reusable UI components. AppButton, AppTextField. If there is a style that is used in more than one place in app then add it the MainStyleSheet as shown below in code sample.

Most of the views are inspectable and of IBDesignable to easily modify. If changes are made via IB then please update values in `UIColor.Palette` and Main stylesheet.

```
static let underlinedButtonClear = Style<UIButton> {
let attribs : [NSAttributedString.Key: Any] = [
NSAttributedString.Key.font : Assets.Font.workSansRegFont.getFont().withSize(13.0),
NSAttributedString.Key.foregroundColor : UIColor.Palette.shamrockGreen,
NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
$0.backgroundColor = UIColor.clear
let attributeString = NSMutableAttributedString(string: $0.titleLabel?.text ?? "",
attributes: attribs)
$0.setAttributedTitle(attributeString, for: .normal)
}
```

Apply style to a view

```
self.apply(Stylesheet.Main.underlinedButtonClear) where 'self' is of type UIButton
```

The app reads from an extension on UIColor called Palette. `UIColor.Palette` contains all of the reusable colors.

Get a color:

```
let buttonBackgroundColor = UIColor.Palette.manatee

```
## Architecture

The folder structure is pretty straightforward. It's divided into common, vendor, state(redux), configurations, screens, services, resources, scripts.

The project is utilizing a Redux unidirectional data flow pattern. The specific Swift Redux implementation can found here on [ReSwift's](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwiYhMHE94ThAhVrFTQIHbDQA7kQFjAAegQIABAC&url=https%3A%2F%2Fgithub.com%2FReSwift%2FReSwift&usg=AOvVaw2wEAeFauovveN4srzyvalb) page. ReSwift was chosen due to it's popularity, support and small library size. Redux implementation like this allows Android and iOS to follow a similar pattern to make sure codebases are not too far apart. Also, helps separate app into components.

_Actions_ - Allow views to trigger an 'action' to take place. Such as navigate to the dashboard upon clicking a button. Only through an action can the state be updated.

_State_ - Keeps track of the app's current state in one place. Main app state is divided into meaningful substates that correspond to a use case.

_Views_ - Views can subscribe/listen to state changes allowing are UI components to be dynamic based on app state.

_Services_ - Contain all of are API service requests, logging implementation, session timeout and logic that deserves to be placed in a services layer.

_Configurations_ - Build configurations to separate dev, staging and production environments.

_Routing_ - App navigation routing. Logic to direct users to the correct screen based upon current app state.

Display a new screen by providing destination view id and method of presenting view.

```
store.dispatch(RoutingAction(destination: .termsConditionInstruction, transitionType: .push))
```

_Screens_ - All of the screens within app are contained in a single spot. Screens are then divided into logical components that make sense based upon use case. Authentication would contain screens related to login, logout, reset password, etc.

_Common_ - This is used for Utilities, extensions, and generic classes that are shareable with whole application

_Vendor_ - Used for containing third party code

### Scenes

Holds all the screens such as Login and Register view controllers. Currently the screens are grouped by module or feature. For instance the Authentication folder contains Landing, Register, and Login screens. Each screen has a

Creating a new screen such as a Login screen

1. Create new folder if large enough
2. Create storyboard and viewController for screen

### Screen Management

`OneHeroScreens` contains 2 enums (StoryboardNames & RoutingDestination). RoutingDestination represents each screen id and should match whats in the Storyboard. StoryboardNames represents the name of each storyboard.

Pushing a new view onto main navigation stack

```
store.dispatch(RoutingAction(destination: .forgotLogin, transitionType: .push))
```

Pushing & popping view onto the navigation stack coming using hamburger menu

```

Navigating back
store.dispatch(RoutingAction(destination: .undefined, transitionType: .backUsing(navType: .SideMenuNav), animationType: .standard))

Pushing
 store.dispatch(RoutingAction(destination: .faqs, transitionType: .pushFromSidemenu, animationType: .standard))

 Showing an alert
 let alert = AlertViewModel(message: "Alert message", title: "")
 store.dispatch(RoutingAction(destination: .alert(alert), transitionType: .alert, animationType: .standard))
```

Lets work through an example to setup a Login Screen.

1. First create a folder named Login, then add your view controller and storyboard
2. Next add your new storyboard id to `OneHeroScreens` and view controller string id
3. Follow below to learn how to subscribe to state changes

### Listen/Subscribe to state changes

```
Subscribe and select on substate of main AppState in the `viewWillAppear` method
        store.subscribe(self) {
            $0.select {
                $0.authenticationState
            }
        }
      }
```

```
Unsubscribe to prevent unnecessary state changes when view isn't in focus `viewWillDisappear` method
         store.unsubscribe(self)
```

```
Then extend `StoreSubscriber` to get new state updates
// MARK: - Login State Changes
extension LoginViewController: StoreSubscriber {
    func newState(state: AuthenticationState) {
      switch state.signInState {
 case .success:
     hideLoading()
     if state.mfaRequired{
         finishSuccessLogIn()
     }else{
         store.dispatch(RoutingAction.init(destination: .home, transitionType: .root))
     }

     break
 case .notSignedIn:
     hideLoading()
     Log.d("Not signed in.")
     break
 case .signingIn:
     DispatchQueue.main.async {
         OneHeroProgressView.shared.showProgressView()
     }
     Log.d("Signing IN.....")
     break
 case .failure:
     hideLoading()
     handleLoginFailAttept(error: state.attemptError)

     Log.d("Failure.....")
     break
 }
    }
  }
```
