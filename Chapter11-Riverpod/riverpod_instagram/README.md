# Riverpod Instagram

An Instagram Clone App built with [Riverpod](https://github.com/rrousselGit/riverpod) and [Firebase](https://firebase.google.com/).

## Run it

Follow the steps below to start this app.

### Setup Firebase

1. Following [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup)

2. Enable Email/Password Authentication in [Firebase Console](https://console.firebase.google.com/)

3. (Optional) As I am building this application on the Linux operating system, I am unable to verify whether this application can run properly on the IOS platform. 

   If you want to run on IOS devices, Firebase requires a minimum platform target of IOS 13.0, so you need to enter Podfile and uncomment the platform line, then change it to `platform: IOS,' 13.0 `. 

   then, open your terminal, and run following commands:

   ```shell
   cd ios
   
   pod deintegrate
   
   pod install --repo-update
   ```

   after that, run this flutter app in IOS device as simply.

4. ...

### Run

```shell
flutter pub get

flutter run
```

## Features

- Social Login (Google & Facebook)

## Packages

  firebase_core: ^2.9.0

  firebase_auth: ^4.2.2

  firebase_storage: ^11.1.0

  cloud_firestore: ^4.5.1

  uuid: ^3.0.7

  riverpod: ^2.3.4

  flutter_hooks: ^0.18.6

  hooks_riverpod: ^2.3.4

  font_awesome_flutter: ^10.4.0

  flutter_facebook_auth: ^5.0.8

  google_sign_in: ^6.1.0

  image_picker: ^0.8.7+3

  image: ^4.0.15

  collection: ^1.17.0

  intl: ^0.18.0

  video_thumbnail: ^0.5.3

  video_player: ^2.6.1

  lottie: ^2.3.2

  share_plus: ^6.3.2

  url_launcher: ^6.1.10

## About

https://github.com/hwangblood/flutter-state-management/tree/master/Chapter11-Riverpod/riverpod_instagram
