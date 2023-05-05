# MobX Reminders

A Flutter CRUD Reminders App built with [MobX](https://mobx.netlify.app/) and Firebase.

## Timestamp

[01:48:13](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=6493) Define action for setting reminders as done

[01:55:24](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=6924) Initialize our app state

## Setup Firebase

1. Create a FIrebase project for this app in Firebase Console

2. Enable **Email/Password** Sign-in method

3. Enable **Cloud Firestore** Databse, and set the database rules like bellow:

   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{collection}/{document=**} {
       	function isCollectionOwner(collectionId) {
         	return request.auth != null && request.auth.uid == collectionId;
         }
         // the update rule includes delete rule, so the delete rule in no-need here
         allow create, read, update, write, delete: if isCollectionOwner(collection);
       }
     }
   }
   ```

4. ...

## Run app

```shell
flutter pub get

flutter run
```
