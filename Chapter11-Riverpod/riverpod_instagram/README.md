# Riverpod Instagram

An Instagram Clone App built with [Riverpod](https://github.com/rrousselGit/riverpod) and [Firebase](https://firebase.google.com/).

## Getting Started

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

### Run app

```shell
flutter pub get

flutter run
```
