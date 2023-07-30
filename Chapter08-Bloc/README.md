# Bloc State Management

Bloc and Flutter Bloc are two very popular and useful libraries for Dart and Flutter developers respectively. They allow you to separate your business logic from your application's UI to an extent UI work is greatly simplified thanks to the simplicity of integrating Bloc and Flutter Bloc into an application.

# Getting Started

Each step of the course is in its own tag and commit so either check the various commits out or go to various tags.

I have deleted the Firebase project backing this app for security reasons so before you get started, set up your firebase backend as shown in the video of course (https://youtu.be/Mn254cnduOY)

# Table of Content

1. [Cubit Example](./cubitexample_course/)
1. [First Bloc Example](./firstblocexample_course) with Testing

# Examples

| Name                                                         | Description                                                  | Features                                                     | Demo                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Cubit Example](./cubitexample_course)                       | Just a simple easy cubit example.                            | Cubit, Stream, StreamBuilder                                 | ![first_cubit_example](.README.assets/cubit_example.gif)     |
| [First Bloc Example](./firstblocexample_course) with Testing | Display two list of users data that fetched form network and cached by Bloc. | API by Live Server, caching data with Bloc                   | ![first_bloc_example](.README.assets/first_bloc_example.gif) |
| [Multistate Notes App](./multistateblocs_example) Needs Testing | A Bloc that has multiple kinds of states, it's gonna hold on a variable knowing whether you're logged or not, and also allow you to fetch some notes (No real network calls in this app). You can login with a fake user: `hwnagblood@gmail.com --- asdfghjkl` | Login with dummy api, Only One BlocProvider, Dependency Inject | ![bloc-notesapp](.README.assets/bloc-notesapp.gif)           |
| [MultiBlocProvider Example](./multiblocprovider_example) Needs Testing | Display two images with two different Bloc, and both of these have the same logic, and show next image per 10 secondes using `Stream.periodic()` |                                                              | ![bloc-multiblocprovider](.README.assets/bloc-multiblocprovider.gif) |
| [Bloc Photo Gallery](./bloc_photo_gallery)                   | Build a Photo Gallery App with Firebase Authentication and Firebase Storage. see more [details of this app](./bloc_photo_gallery/README.md) - [timestamp of this app](./bloc_photo_gallery/timestamp.md) in the course |                                                              |                                                              |



# Source Code

Checkout [youtube-course-bloc](https://github.com/vandadnp/youtube-course-bloc) repository of this course by [Vandad Nahavandipoor](https://www.youtube.com/@VandadNP)
