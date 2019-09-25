# BabylonPosts

[![Build Status](https://app.bitrise.io/app/1fec8bedb1c2fb24/status.svg?token=nIZVhuKRoCi3fMTDXc1rfg)](https://app.bitrise.io/app/1fec8bedb1c2fb24)

This is a demo project for Babylon Health's interview. The full requirements about the demo can be found [here](https://github.com/Babylonpartners/ios-playbook/blob/master/Interview/demo.md#1-the-babylon-demo-project).


# Installation

Download the zip file or checkout the project. 

Open file `BabylonPosts.xcworkspace` in the root folder in Xcode 11.0.

# Project structure

The project generally uses MVVM pattern but with some simplifications. A bespoke navigator pattern is created to navigate between different use cases. There is no Main.storyboard in the project as the navigator takes care of the flow. Detailed explanations of each major components can be found below:

## View Model

## Navigator

## Data coordinator

## Unit tests


# Software and versions
* Xcode 11.0
* CocoaPods 1.8.0


# Continues integration

[Bitrise](https://www.bitrise.io/) is used for continues integration. A webhook is set on the GitHub repository.

