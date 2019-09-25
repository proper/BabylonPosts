# BabylonPosts

<p align="center">
<img src="AppIcon.png">
</p>

[![Build Status](https://app.bitrise.io/app/1fec8bedb1c2fb24/status.svg?token=nIZVhuKRoCi3fMTDXc1rfg)](https://app.bitrise.io/app/1fec8bedb1c2fb24)

This is a demo project for Babylon Health's interview. The full requirements about the demo can be found [here](https://github.com/Babylonpartners/ios-playbook/blob/master/Interview/demo.md#1-the-babylon-demo-project).


## Installation

Download the zip file or checkout the project. 

Open file `BabylonPosts.xcworkspace` in the root folder in Xcode 11.0 and run the target `BabylonPosts`.

## Project folder structure

* **BabylonPosts**
  * **UseCases** (Use cases of the app. Each use case is an independent component, which can be used in any flow.)
    * **Posts** (Code for Posts screen)
      * **Navigators** (ViewModel level navigation code)
      * **UI** (UIViewController and cells)
      * **ViewModel** (ViewModel for posts and cells)
    * **PostDetail** (Code for post detail screen)
  * **DataManager**
    * **API** (Endpoints configuration)
    * **DataCoordinator** (The coordinator of data.)
    * **Models** (All of the models used in the app are defined here in a central place.)
    * **Network** (Network related code to get data from the internet)
    * **Persistence** (Cache the data in the cache folder to be used when offline)
  * **Navigators** (App level navigation code and shared navigation related definitions)
  * **Shared** (Shared utilities and interfaces)
    * **Protocols** (Shared protocols)
  * **AppDelegate.swift** (The entry of the app, where the app navigator is created and services injected)
* **BabylonPostsTests**
  * **MockAssets** (Normally dummy JSON files to assist models creation)
  * **Mocks** (Mock classes of the injected services)
  * **Shared** (Shared utilities)
  * **Tests** (The tests)

## Architecture

The project generally uses MVVM pattern but with some simplifications. View models handle the business logic and update the views. A bespoke navigator pattern is created to navigate between different use cases and handle error pop ups. There is no `Main.storyboard` in the project as the navigator takes care of the flow. A data coordinator handles making network calls and decoding the data into predefined data models. It also handles data persistency in case the device is offline.

**Dependency Injection** is heavily used through protocols. The `DataCoordinator` and `Navigator` are injected into each ViewModel, which makes it very easy to test.

Detailed explanations of each major components can be found below:

### View

A View is typically the `UIViewController`. Each View holds it's own ViewModel. The View notifies the ViewModel the related changes, such as `viewDidLoad`. When the ViewModel's models are changed, the View will be notified to handle the changes.

### ViewModel

ViewModel handle the business logic in it's use case.

A typical ViewModel contains the following:

* **Data coordinator** gets the data model from the network or the persistence layer, and is injected through `init`.
* **Navigator**. navigates to different use case's navigator and is injected through `init`.
* **Models** data models ready to be displayed on the View.
* **View binding logic** which is archived by binding closures. Once the model changes, the View will be notified.
* **View events** such as `viewDidLoad`. So the business logic is decoupled from the View.

### Navigator

Each ViewModel holds it's own navigator. The navigator is in charge of navigating to other use cases or handling errors. The app's entry navigator is the `AppNavigator`. Navigator has a dependency on the `UINavigationController`

### Data coordinator

To make the app work offline, DataCoordinator is introduced to handle network calls and data persistency.

`NetworkService` provides an asynchronies interface to fetch the data. `Alamofire` is used in `DefaultNetworkService` to handle calls to the internet and decode data models. `URLSession` can be used too.

`StorageService` handles persistence of data. `DefaultStorageService` is the concrete class to persist data on disk in Cache folder. However any other services, like CoreData, can be used too.

### Unit tests

The major ViewModels, `DefaultPostsViewModel` and `DefaultPostDetailViewModel`, are unit tested. 

### Naming convention

The protocol based interface generally is named after it's type, such as PostsNavigator. The name of the concrete class of the protocol has a prefix `Default`.

### Pods used

* **SwiftLint** 0.35 to enforce coding style
* **PromiseKit** 6.8 to make network calls easier to handle and to demo the network synchronization
* **Alamofire** 5.0.0-rc.2 for easy network calls and model decoding. One line of code literally!
* **JGProgressHUD** 2.0.4 to show the loading state of the UI.

## Software and versions

* Xcode 11.0
* CocoaPods 1.8.0
* iOS 12.0 and above, iPhone only
* Swift 5.0
* Tested on iPhone 7 with 12.4.1

## Continues integration

[Bitrise](https://www.bitrise.io/) is used for continues integration. A webhook is set on the GitHub repository to trigger CI builds on new commits.

