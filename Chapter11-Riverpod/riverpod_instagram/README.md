# Riverpod Instagram

An Instagram Clone App built with [Riverpod](https://github.com/rrousselGit/riverpod) and [Firebase](https://firebase.google.com/).

## Setup

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

4. Enable Cloud FireStore, and edit rules like:

   ```objective-c
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{collectionName}/{document=**} {
           allow read, update: if request.auth != null;
           allow create: if request.auth != null;
           // Only allow users to delete their own likes and comments
           allow delete: if request.auth != null && ((collectionName == "likes" || collectionName == "comments") || request.auth.uid == resource.data.uid);
       }
     }
   }
   ```

5. Enable Firebase Storage, and edit rules like:

   ```objective-c
   rules_version = '2';
   service firebase.storage {
     match /b/{bucket}/o {
       match /{collectionId}/{allPaths=**} {
         // Each user has a storage collection with the same name as their uid
         allow create, update, write: if request.auth != null && request.auth.uid == collectionId;
         allow read: if request.auth != null;
       }
     }
   }

6. ...

### Setup Facebook Sign-in

- Firstly, Create a app with **Comsumer** type in [Meta for Developers - Facebook](https://developers.facebook.com/)
- After app created, You can find **APP ID** and **APP KEY** in app's settings
- Open your project in **Firebase Console**
- Follow **Authentication** > **Sign-In Method** > Add **Facebook Provider** > Input  **APP ID** and **APP KEY**
- Also, You need to add OAuth redirect URI to **Facebook App Settinngs** then Save it
- Back to your Facebook App Dashboard
- Add **Facebook Login Product** for App, next to **Quickstart**
- Choose **IOS** platform:
  - Setup Development Environment, select **SDK: Cocoapods** and go to **Next**
  - Add Bundle Identifier, paste your app's **Bundle ID**, then **Save** it and go to **Next**
  - Enable Single Sign On: toggle it to **YES**, then **Save** it and go to **Next**
  - Configure Your `Info.plist`: just follow the steps (exclude **Keychain Sharing Capability**), then go to **Next**
  - Conenect App Delegate: we don't have to do any of this native Swift code, because we're actually using Flutter, please go to **Next**
  - Add Facebook Login Button: we also don't  have to do this native Swift code, just go to **Next**
  - Check Current Login Status: also navite Swift code, jump it and go to **Next**
  - Ask for Permissions: jump this native Swift code, jump it and go to **Next**
  - Now, we have added **Facebook Login** to IOS app
  - Congrats!
- Choose **Android** platform:
  - Download the Facebook SDK for Android: we don't have to do this, because we're using Firebase, go to **Next**
  - Import the Facebook SDK: follow the steps (but exclude import Facebook SDK package), then go to **Next**
  - Tell About Android Project: input **Package Name** and **Default Activity Class Name**, then **Save** it and go to **Next**
  - Add Development and Release Key Hashes: paste your keys, then **Save** it and go to **Next**
  - Enable Single Sign On: toggle it to **YES**, then **Save** it and go to **Next**
  - Edit Resources and Manifest: follow all the steps (maybe you need to create `app/res/values/strings.xml` file), then go to **Next**
  - Log App Event: don't have to do this natively, we 're going to throught it in Flutter, then go to **Next**
  - Add Facebook Login Button: we also don't  have to do this native Kotlin code, just go to **Next**
  - Register a Callback: no need to do this, go to **Next**
  - Check Login Status: no need to do this, go to **Next**
  - Now, we have added **Facebook Login** to Android app
  - Congrats!
- It's time to add OAuth redirect URI to FAcebook App Setting
- Find **Facebook Login** in app's Products, go to its **Settings**
- paste valid OAuth redirect URI, and save it.
- And, there are some in-need steps to do in [flutter_facebook_auth | Flutter Package - Pub.dev](https://pub.dev/packages/flutter_facebook_auth)

### Setup Google Sign-in

- Open your project in **Firebase Console**
- Follow **Authentication** > **Sign-In Method** > Add **Google Provider** 
- Toggle siwtch button to **TRUE**, then input **Project public-facing name** (eg. `riverpod-instagram`) and **Project support email**, and **Save** it to go ahead
- finally, you need to re-download `google-services.json` for Android and `GoogleService-Info.plist` for IOS, then rebuild your app
- follow [google_sign_in | Flutter Package - Pub.dev](https://pub.dev/packages/google_sign_in)
- Add **SHA Certificate Fingerprint** to Android apps in Firebase project settings

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

