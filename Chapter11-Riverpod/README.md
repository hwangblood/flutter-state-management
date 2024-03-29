# Riverpod State Management

Welcome to this massive course on Riverpod 2.x. We will implement an Instagram photo and video sharing application with Riverpod in this course using social sign-ins such as Facebook and Google! We use Firebase Firestore to store our documents and Firebase Storage to store photos and videos.

**How is the course structured?** 

We start off by creating 6 example applications using Riverpod before we get to the Instagram implementation. The examples get progressively more difficult so grab a cup of coffee or tea!

**Who is this course for?** 

This course is for those who want to either learn Riverpod from scratch or  I assume that you are already quite comfortable with Flutter and don't need explanation as to how to use basic Flutter widgets such as Row and Column. We will also use Flutter Hooks in small portions of our app. Knowledge of Flutter Hooks is not at all required in order to take this course on Riverpod! However, if you are are curious about Flutter Hooks and want to learn it from the ground up, you can watch Vandad's free full course on it by following this link [https://youtu.be/XsbxM1Aztpo](https://www.youtube.com/watch?v=XsbxM1Aztpo&t=0s)

# Examples

| Name                                                         | Description                                                  | Features                                                     | Preview                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Provider Example](./example1_provider)                      | Basic Provider (Just provide a value, nothing special)       | [Provider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/provider) |                                                              |
| [StateNotifierProvider Example](./example2_statenotifierprovider) | Store count in a StateNotifier, and listen to its change of state with StateNotifierProvider. | StateNotifier (in package [state_notifier](https://pub.dev/packages/state_notifier)), [StateNotifierProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/state_notifier_provider) (not recommanded) | ![example2_StateNotifierProvider](.README.assets/example2_StateNotifierProvider.gif) |
| [FutureProvider Example](./example3_futureprovider)          | Show weather for special city, when click on city radio, update current city and fetch weather with FutureProvider. (Default show a smile emoji 😊) | [StateProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/state_provider)  (not recommanded), [FutureProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/future_provider) | ![example3_FutureProvider](.README.assets/example3_FutureProvider.gif) |
| [StreamProvider Example](./example4_streamprovider)          | Display a names list depend on a timer, it ticks per second (Stream of int), every time timer ticked names list will be update, when timer's count is out of the length of name array display a error text. | [StreamProvider](https://docs-v2.riverpod.dev/zh-Hans/docs/providers/stream_provider) | ![example4_StreamProvider](.README.assets/example4_StreamProvider.gif) |
| [ChangeNotifierProvider Example](./example5_changenotifierprovider) | Display, Create, Update, Delete (not be used) People with ChangeNotifierProvider | ChangeNotifier, [ChangeNotifierProvider](https://docs-v2.riverpod.dev/zh-hans/docs/providers/change_notifier_provider) (not recommanded) | ![example5_ChangeNotifierProvider](.README.assets/example5_ChangeNotifierProvider.gif) |
| [StateProvider Example](./example6_stateprovider)            | Display a list of films with ChangeNotifierProvider also can change the favorite status of each film by click on icon button, and use StateProvider to change the current filter type of films to be show on screen. (use Provider caching favorite or not-favorite films, easy to filter films with filter condition) | Provider, StateProvider, StateNotifiterProvider              | ![example6_StateProvider](.README.assets/example6_StateProvider.gif) |
| Instagram Clone                                              |                                                              |                                                              |                                                              |



# Source Code

Checkout [youtube-riverpodcourse-public](https://github.com/vandadnp/youtube-riverpodcourse-public) repository of this course by Vandad Nahavandipoor
