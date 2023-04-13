# Contacts with RxDart

A fully fledged contacts app with Firebase integration together with authentication and storage.

## Getting Started

**Setup Firebase:**

1. Following [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup)

2. Enable email and pasword authentication in [Firebase Console](https://console.firebase.google.com/) ([see more details](./enable-email-password-authentication.md))

3. (Optional) As I am building this application on the Linux operating system, I am unable to verify whether this application can run properly on the IOS platform. 

   If you want to run on IOS devices, Firebase requires a minimum platform target of IOS 13.0, so you need to enter Podfile and uncomment the platform line, then change it to `platform: IOS,' 13.0 `. 

   then, open your terminal, and run following commands:

   ```shell
   cd ios
   
   pod deintegrate
   
   pod install --repo-update
   ```

   after that, run this flutter app in a IOS device as simply.

4. Setup Cloud Firestore rules in [Firebase Console](https://console.firebase.google.com/)

   for this app, Each authenticated user will have a collection with the same id as the user id in the Cloud Firestore. And users can only operate in their own collection such as CRUD. see the detail about [how to setup firestore rules](./setup-firestore-database.md).

## TODO

- [ ] Cannot Create new contact , delete contact, delele all contacts (when delete account)

**Run app:**

```shell
flutter pub get

flutter run
```

