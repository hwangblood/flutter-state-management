# MobX Reminders

A Flutter CRUD Reminders App built with [MobX](https://mobx.netlify.app/) and Firebase.

## App Preview

TODO

## Timestamp

[01:48:13](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=6493) Define action for setting reminders as done

[01:55:24](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=6924) Initialization of our app state

[01:58:03](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=7083) Private action for loading reminders

[02:02:10](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=7330) Action for logging in or registering

[02:07:50](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=7670) Action for registering

[02:09:43](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=7783) Action for logging in

[02:10:26](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=7826) Bring auth errors into project

[02:10:33](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=7833) Bring delete-account dialog into project

[02:13:46](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8026) Bring log-out dialog into project

[02:14:08](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8048) Bring auth-error dialog into project

[02:15:18](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8118) Create dialog for deleting reminder

[02:16:30](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8190) Create text-filed dialog for creating reminder

[02:25:09](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8709) We are done with dialogs, next things to do?

[02:26:56](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8816) IfDebugging String Extension

[02:27:28](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8848) Bring loading screen and controller into project

[02:32:29](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=9149) Create the login view(screen)

[02:44:48](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=9888) Create the register view(screen)

[02:46:33](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=9993) Implement MainPopupMenuButton widget

[02:50:10](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=10210) Create the reminders view(screen)

[03:05:57](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=11157) Put all together and fix errors

[03:32:58](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=12778) Refactoring before testing

[03:34:58](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=12898) implement auth provider

[03:48:42](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=13722) implement reminders provider

[04:07:52](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=14872) Dependency injection into AppState

[04:10:36](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=15036) Update AppState to use dependencies

[04:29:22](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=16162) Update AppState to only require reminderId when modifying it

[04:31:32](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=16292) some utils for testing

[04:37:18](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=16638) Implementing MockAuthProvider

[04:42:55](https://youtu.be/7Od55PBxYkI?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=16975) Implementing MockRemindersProvider

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

flutter pub run build_runner watch --delete-conflicting-outputs

flutter run
```
