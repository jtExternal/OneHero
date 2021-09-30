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

Project has a Theme folder that contains all of the custom reusable UI components. AceAppButton, AceAppTextField. If there is a style that is used in more than one place in app then add it the ACEMainStyleSheet as shown below in code sample.

Most of the views are inspectable and of IBDesignable to easily modify. If changes are made via IB then please update values in `UIColor.Palette` and Main stylesheet.

```
static let aceUnderlinedButtonClear = Style<UIButton> {
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
self.apply(Stylesheet.Main.aceUnderlinedButtonClear) where 'self' is of type UIButton
```

The app reads from an extension on UIColor called Palette. `UIColor.Palette` contains all of the reusable colors.

Get a color:

```
let buttonBackgroundColor = UIColor.Palette.manatee
```
