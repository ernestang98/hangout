# Hangout Administration Interface

### Demo Video:

https://www.youtube.com/watch?v=tdhDdc9UXHw

### How to run:

```bash
flutter clean
flutter pub get
flutter run --no-sound-null-safety -d web-server --web-renderer=html
flutter run --release --no-sound-null-safety -d web-server --web-renderer=html
```

### How to test:

```bash
flutter drive --driver=test/integration_test.dart --target=test/page_authentication_widget_test.dart -d web-server --web-renderer=html --no-sound-null-safety 
flutter drive --driver=test/integration_test.dart --target=test/page_authentication_widget_test.dart -d web-server --web-renderer=html --no-sound-null-safety --no-headless
flutter drive --driver=test/integration_test.dart --target=test/page_authentication_widget_test.dart -d web-server --web-renderer=html --release --no-sound-null-safety --no-headless
```

### How to deploy:

```bash
flutter clean
flutter pub get
flutter build --no-sound-null-safety -d web-server --web-renderer=html 
flutter build --release --no-sound-null-safety -d web-server --web-renderer=html
```

### References:

- [Flutter Registration Reference](https://github.com/kevinjnguyen/flutter-firebase-registration-ui)

- [Flutter Navigator](https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31)

- [Flutter Web Firebase Installation](https://firebase.flutter.dev/docs/installation/web/)

- [Flutter Web Firebase Auth](https://blog.codemagic.io/flutter-web-firebase-authentication-and-google-sign-in/)

- [Flutter Web Firebase Realtime](https://firebase.flutter.dev/docs/database/overview)

    - [Flutter Web Firebase Realtime example](https://stackoverflow.com/questions/59670753/flutter-firebase-realtime-database-in-web)

    - [Flutter Mobile Firebase Realtime example #1](https://medium.com/firebase-tips-tricks/how-to-use-firebase-realtime-database-with-flutter-ebd98aba2c91)

    - [Flutter Mobile Firebase Realtime example #2](https://medium.com/flutterdevs/explore-realtime-database-in-flutter-c5870c2b231f)

    - [Flutter Realtime Database CRUD](https://medium.com/flutterdevs/explore-realtime-database-in-flutter-c5870c2b231f)

    - Reading Firebase Realtime Database using Flutter Web is quite difficult but possible 
      
        - Firebase for Flutter Web works quite differenty from Firebase Flutter
    
        - need to infer from the links below, cannot directly copy-paste oops

        - https://stackoverflow.com/questions/61975088/how-to-retrieve-data-from-firebase-realtime-with-flutter

        - https://stackoverflow.com/questions/65853600/firebase-once-method-does-not-wait-on-flutter

        - https://stackoverflow.com/questions/62021105/querying-firebase-real-time-database-using-firebase-package-unknown-input-parame

        - https://firebase.google.com/docs/reference/js/v8/firebase.database.Query#eventtype:-eventtype_1

        - https://firebase.google.com/docs/reference/js/v8/firebase.database.DataSnapshot

- [Flutter Firebase Firestore](https://firebase.flutter.dev/docs/firestore/overview)

    - [Flutter Mobile Firebase Firestore #1](https://medium.com/enappd/connecting-cloud-firestore-database-to-flutter-voting-app-2da5d8631662)

- [Disable swipe to pop](https://stackoverflow.com/questions/49161644/flutter-disable-swipe-to-navigate-back-in-ios-and-android)

- [Flutter Web Firebase Storage](https://stackoverflow.com/questions/59716944/flutter-web-upload-image-file-to-firebase-storage)


### Firebase things:

- [push()](https://firebase.google.com/docs/database/admin/save-data#getting-the-unique-key-generated-by-push)


### Errors/Notes:

- [Cannot read properties of undefined (reading 'app')](https://stackoverflow.com/questions/69076827/cannot-read-properties-of-undefined-reading-app)

    - Firebase for Flutter web and Flutter mobile have different configurations and setups

- [No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp() in Flutter and Firebase](https://stackoverflow.com/questions/63492211/no-firebase-app-default-has-been-created-call-firebase-initializeapp-in)

- [Flutter Web Firebase TypeError: dart.global.firebase.firestore is not a function](https://stackoverflow.com/questions/63248596/flutter-web-firebase-typeerror-dart-global-firebase-firestore-is-not-a-function)

- [flutter web TypeError: dart.global.firebase.storage is not a function](https://stackoverflow.com/questions/65893016/flutter-web-typeerror-dart-global-firebase-storage-is-not-a-function/65958441)

- If using firestore/realtime database, you need to set up the realtime and firestore databases before you generate the sdk credentials. Make sure the sdk config credentials include the realtime db url!!!

- [Flutter images not loaded (EXCEPTION: resolving an image codec)](https://stackoverflow.com/questions/50130933/flutter-images-not-loaded-exception-resolving-an-image-codec)

- [Flutter cant load image from url](https://stackoverflow.com/questions/65872585/flutter-cant-load-image-from-url/65883003)

- [Alert Dialog and Confirmation Dialog in Flutter](https://medium.com/multiverse-software/alert-dialog-and-confirmation-dialog-in-flutter-8d8c160f4095)

- [Deleting dta under a key in firebase](https://stackoverflow.com/questions/52658275/deleting-data-under-a-key-in-firebase)

- [How to delete whole key data in firebase database?](https://stackoverflow.com/questions/49085038/how-to-delete-whole-key-data-in-firebase-database)

- [Flutter Web - How to reload currently Active Page](https://stackoverflow.com/questions/59588102/flutter-web-how-to-reload-currently-active-page)

- [How to pass parameters to widgets in Flutter](https://stackoverflow.com/questions/53659570/how-to-pass-parameters-to-widgets-in-flutter)

- [Passing Data to a Stateful Widget](https://stackoverflow.com/questions/50818770/passing-data-to-a-stateful-widget)

- [Writing, Deleting and Updating Data in Firebase Realtime Database with JavaScript](https://medium.com/@hasangi/writing-deleting-and-updating-data-in-firebase-realtime-database-with-javascript-f26113ec8c93)

- [Passing Data to a Statefuless Widget](https://gist.github.com/felagund18/4ea58e1b4d6646797e866d1c583ca1b0)

### Hangout Mobile Application

- [Click here! (separate private repository, require access)](https://github.com/lamzf1998/CZ3002-Hangout)

### Deployment (Heroku)

1. https://mac-and-cheese-admin.herokuapp.com/#/

1. [Tutorial on YouTube for Dart (infer to deploy for flutter)](https://www.youtube.com/watch?v=IRZ7WH98lLA)

1. Setting up Heroku via CLI
    ```bash
    heroku login
    heroku git:remote -a mac-and-cheese-admin
    heroku buildpacks:set https://github.com/natancamenzind/heroku-buildpack-flutter.git (Flutter)
    heroku buildpacks:set https://github.com/stablekernel/heroku-buildpack-dart.git (Dart)
    ```
2. For Dart: 

    - Go to https://dart.dev/get-dart/archive

    - Select Linux OS, x64 Architecture, Dart SDK

    - Go to Heroku Dashboard, config vars, set DART_SDK_URL to the Dart SDK link
    
3. For Flutter: 

    - Go to Heroku Dashboard, config vars, set BUILD to the flutter run command

    - https://stackoverflow.com/questions/62397807/how-to-deploy-flutter-web-on-heroku

        ```bash
        git push heroku master
        ```
    - Branch that you push to on heroku **MUST** be `master` or else it will not work

        - originally ran `git push heroku deploy`, and it didnt work

        - ran `heroku repo:reset` before running `git push heroku master`
        
        - run `git push heroku HEAD:master` if encounter [heroku: src refspec master does not match any](https://stackoverflow.com/questions/26595874/heroku-src-refspec-master-does-not-match-any)

    - Make sure your environment variables start with `FLUTTER_*`

        ```
        heroku config:set FLUTTER_BUILD="flutter build web --release --no-sound-null-safety --web-renderer=html" -a mac-and-cheese-admin
        ```

    - Following errors observed when build push to heroku second time:

        ```
        remote: -----> Saving Flutter SDK in Cache
        remote: -----> dhttpd Found in cache. Restoring.
        remote: cp: cannot create regular file '/app/.pub-cache/git/cache/flutter-icons-ecc536b2ab1ade7832f326a6b4ad2ccf9eb4aa6e/objects/pack/pack-0f43ab32997e19f76505c149597bd17ca959844d.idx': Permission denied
        remote: cp: cannot create regular file '/app/.pub-cache/git/cache/flutter-icons-ecc536b2ab1ade7832f326a6b4ad2ccf9eb4aa6e/objects/pack/pack-0f43ab32997e19f76505c149597bd17ca959844d.pack': Permission denied
        remote: cp: cannot create regular file '/app/.pub-cache/git/flutter-icons-0831af6f0f239d20fb9578612d7a893e2a53d044/.git/objects/pack/pack-0f43ab32997e19f76505c149597bd17ca959844d.idx': Permission denied
        remote: cp: cannot create regular file '/app/.pub-cache/git/flutter-icons-0831af6f0f239d20fb9578612d7a893e2a53d044/.git/objects/pack/pack-0f43ab32997e19f76505c149597bd17ca959844d.pack': Permission denied
        remote:  !     Push rejected, failed to compile https://github.com/natancamenzind/heroku-buildpack-flutter.git app.
        remote: 
        remote:  !     Push failed
        remote: Verifying deploy...
        ```
        Relevant Links:
        
        https://github.com/natancamenzind/heroku-buildpack-flutter
        
        https://github.com/phoenixframework/phoenix_live_view/issues/526
        
        https://stackoverflow.com/questions/24965953/error-pushing-to-heroku
        
        https://help.heroku.com/18PI5RSY/how-do-i-clear-the-build-cache

        Hot Fix:
        ```
        heroku config:set FLUTTER_CACHE=true -a mac-and-cheese-admin
        heroku plugins:install heroku-builds
        ```

        Problem: I think Heroku or something does not have permission to access the Flutter SDK in Cache. Below is the logs when you build flutter for first time/build after cache is cleaned. Don't know if it is related to the permissions issue
        ```
        remote: Warning: Pub installs executables into $HOME/.pub-cache/bin, which is not on your path.
        remote: You can fix that by adding this to your shell's config file (.bashrc, .bash_profile, etc.):
        remote: 
        remote:   export PATH="$PATH":"$HOME/.pub-cache/bin"
        ```

4. There is an option to push the subdirectory into heroku
   
    ```
    git subtree push --prefix output heroku master
    ```

### Flutter/Dart Testing:

[Flutter Testing For Beginners - The Ultimate Guide by **Robert Brunhage**](https://www.youtube.com/watch?v=RDY6UYh-nyg)

[How To Mock in Unit Tests in Dart & Flutter by **Filled Stacks**](https://www.youtube.com/watch?v=Kq-YMAE1ssA)

[Unit Testing with Mockito in Flutter by **Tadas Petra**](https://www.youtube.com/watch?v=4d6hEaUVvuU)

[Unit Testing - For Beginners in Dart - Setup with Flutter Project by **Flutter Explained**](https://www.youtube.com/watch?v=C1kzJH8SiuE)

[Flutter test report: junitreport](https://medium.com/ideas-by-idean/flutter-test-reports-in-cis-current-state-of-art-8968b0c8dd4a)

[Flutter test report: Dart Dot Reporter](https://dev.to/apastuhov/make-dart-flutter-test-report-readable-2h0b)

For testing on Flutter Web, is very hard to do unit testing / widget testing (more commonly known as integration/component testing in software engineering). This is because (after reading multiple threads on github and stakeoverflow) there is not much support for Flutter Web given that Flutter was designed initially as a framework for cross-platform mobile application development. Encountered many bugs when trying to perform unit & widget testing:

- [Dart/Flutter Web unit testing errors: Error: Not found: 'dart:html'](https://stackoverflow.com/questions/57982493/dart-flutter-web-unit-testing-errors-error-not-found-darthtml)

- [Flutter Driver test timeout](https://stackoverflow.com/questions/60726510/flutter-driver-test-timeout)

- [Some platform environment error which i could never get pass](https://medium.com/@thevzurd/i-get-unsupported-operation-platform-environment-454171a49313)

- ```bash
  ══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞═════════════════
  The following assertion was thrown running a test:
  Assertion failed:
  file:///Users/ernestang98/flutter/packages/flutter/lib/src/widgets/framework.dart:965:12
  _debugLifecycleState == _StateLifecycle.created
  is not true
  
  When the exception was thrown, this was the stack:
  dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/errors.dart 251:49         throw_
  dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/errors.dart 29:3           assertFailed
  ```

  - [Stakeoverflow link #1](https://stackoverflow.com/questions/65180288/flutter-initstate-returns-debuglifecyclestate-statelifecycle-created-i), [Stakeoverflow link #2](https://stackoverflow.com/questions/55701597/flutter-initstate-returns-a-debuglifecyclestate-error), [Stakeoverflow link #3](https://stackoverflow.com/questions/55701597/flutter-initstate-returns-a-debuglifecyclestate-error)
  - Basically before you setState(), you must  `super.initState()`  first

- ```bash
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "00:00 +0: Simple Test"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "══╡ EXCEPTION CAUGHT BY RENDERING LIBRARY ╞═════════════════════════════════════════════════════════"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "The following assertion was thrown during layout:"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "A RenderFlex overflowed by 76 pixels on the bottom."
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 ""
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "The relevant error-causing widget was:"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "  Column"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "  Column:file:///Users/ernestang98/Desktop/cz3002/lib/screens/page_authentication/page_authentication.dart:159:16"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 ""
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "The overflowing RenderFlex has an orientation of Axis.vertical."
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "The edge of the RenderFlex that is overflowing has been marked in the rendering with a yellow and"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "black striped pattern. This is usually caused by the contents being too big for the RenderFlex."
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the"
  [INFO]: http://localhost:62377/dart_sdk.js 29445:14 "RenderFlex to fit within the available space instead of being sized to their natural si
  ```

  - https://stackoverflow.com/questions/49480051/flutter-dart-exceptions-caused-by-rendering-a-renderflex-overflowed
  - These are like render errors, if you run/test without the --release flag, if there are any overlaps/render errors for your widgets, this assertion error will be thrown. Ideally, you want to deal with them cause it will affect your testing but a hotfix is to run your test with the --release flag.
    - Cannot use `tester.enterText()` in release mode so need to fix [see here](https://giters.com/flutter/flutter/issues/89749)

Hence I skipped to integration testing (more commonly known as system/e2e testing in software engineering). Followed this [link](https://medium.com/flutter-community/writing-ui-teststester-using-integration-test-package-for-flutter-web-77b6a7f37897) and referred to a crap ton of documentation listed below:

- https://flutter.dev/docs/cookbook/testing/unit/introduction
- https://flutter.dev/docs/cookbook/testing/widget/tap-drag
- https://flutter.dev/docs/cookbook/testing/integration/introduction
- https://api.flutter.dev/flutter/flutter_test/findsNWidgets.html
- https://stackoverflow.com/questions/64490039/flutter-widget-test-does-not-trigger-dropdownbutton-onchanged-when-selecting-ano
- https://stackoverflow.com/questions/62153280/flutter-test-find-by-sub-text
- https://newbedev.com/flutter-dart-wait-for-a-few-seconds-in-unit-testing

In the end, couldn't really complete it, encountered alot of difficulties and challenges (e.g. after flutter chromedriver successfully logs in, it doesn't display the home page even though the URL is at the homepage...). Flutter web testing which uses flutter driver also does not support test report and test coverage... ([see here](https://stackoverflow.com/questions/57933204/flutter-driver-test-coverage-report)). All in all, flutter web is not very good as a framework, please use react/vue/angular next time!

### CI with GitHub Actions

- https://github.com/marketplace/actions/setup-chromedriver
- https://damienaicheh.github.io/flutter/github/actions/2021/05/06/flutter-tests-github-actions-codecov-en.html
- Flutter action is for version 2.0.5, but project flutter version is 2.14.+++ :(

### Branch notes:

|      Version                |                 Description                                   |     Comments    |
|-----------------------------|------------------------------------------|--------------------------------|         
|      hangout-deploy-v1      |    Authentication Working, Places of Interests Working        |    Completed     |
|      hangout-deploy-v2      |    full version        |     Completed |
|      main      |    Original, forked from Jethro       |     Completed |
|      testing      |    beta       |  Not Started    |

<!-- https://www.youtube.com/watch?v=W7M9CpCPBcU&feature=youtu.be -->
