# Yaho! demo

This is a demo project for Yaho!. Please read the instruction carefully for compiling guideline and packages used in the project.

## Getting Started

### Requirements

- Have a collection of users presented in both Grid and List view.
- Have all the fields for each item: email, full name and avatar.
- Load users’ avatars and cache them, should have a placeholder.
- Have “loading more” functionality with a “loading more” icon.
- Use either MVVM or BLOC pattern.
- Should have clear UX/UI presentations.
- Have a compiling guideline attached.

## Screens
![Screen Preview](https://github.com/nguyen703/yaho_demo/blob/main/screen-preview.png?raw=true)

## COMPILING GUIDELINE

### Overview for build-helper

In this project, I use some packages to support the development phase. Such as:

- [build_runner: generate files using Dart code](https://pub.dev/packages/build_runner)
- [flutter_gen: code generator for your assets, fonts, colors](https://pub.dev/packages/flutter_gen)
- [freezed: code generator for data-classes/unions/pattern-matching/cloning](https://pub.dev/packages/freezed)

Besides, here are my Android Studio plugins that have helped a lot:

- [Flutter Freezed Snippets: create boilerplate codes for Freezed package](https://plugins.jetbrains.com/plugin/18258-flutter-freezed-snippets)
- [Flutter-Toolkit: make it easier to execute build_runner commands](https://plugins.jetbrains.com/plugin/14442-flutter-toolkit)
- [JsonToDart: quickly generates Dart Model classes from JSON text](https://plugins.jetbrains.com/plugin/12562-jsontodart-json-to-dart-)

For more information, please go to the documentation of each packages and plugins.
You can find below the step-by-step compiling guideline.

### Step-by-step

If you got the Flutter SDK and Dart SDK already, and you did set up its environment completely, you can continue to the following steps. If not, please check the [Flutter documentation](https://docs.flutter.dev) here.  

1. To install flutter_gen, go to Terminal and run this (works with macOS, Linux and Windows): ``dart pub global activate flutter_gen``
2. Next, we go with the famous command: ``flutter pub get``
3. To get those auto-generated codes from the [Freezed] and [FlutterGen] packages, run: ``flutter pub run build_runner build --delete-conflicting-outputs``
4. Get yourself a cup of coffee, this could take from just 5 seconds to minutes, depends on your machine/project size.
5. After that, if your [Dart Analysis] does not show any red dot, you are ready to go. Just press the [Run] button or execute: ``flutter run``

### Attention!
- You may need to set up your iOS-based profile in Xcode (development account).
- From Flutter 3.3 (or any other version you are using), you may encounter the error with Gradle when running in an Android-based, check the following issue from [StackOverflow](https://stackoverflow.com/questions/66920708/update-gradle-in-flutter-project). 


## Project Architecture and Approaches explained

### Project constraints

In a short period of time, I must admit that I cannot list out all the constraints in the project. Here are the ones I used:
- Dart SDK: '>=2.19.2 <3.0.0'
- Flutter SDK: '3.7.3'
- Xcode: 14.2
- Android Studio: Electric Eel

### Project architecture

- Architecture: CLEAN<br />
Separation of Concerns, Maintainability, Testability, etc., we can tell this architecture keeps Software Development at its highest standard. By applying this, we also apply uncle Bob's best practices [SOLID](https://en.wikipedia.org/wiki/SOLID). 
- State management: BLoC (Cubit in particular):<br />
This is the most well-known state management that is used in almost every professional environment in my opinion. For a light project, I prefer using Cubit to minimize the boilerplate codes and decrease shipping-time but still get the power of BLoC.
- Dependency Injection: GetIt<br />
GetIt helps us to get rid of all those dependencies and works well with other State Management.

### What is not included in this project

- Localization and internationalization: Text hardcoded in the codes
- Animation when switching view type
