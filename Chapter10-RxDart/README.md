# RxDart State Management

Rx is a reactive paradigm that builds on top of streams and futures in Dart. These streams are also called Observables in other implementations of Rx, such as RxSwift. In this chapter of the Flutter State Management Course we will work on RxDart and we will create 11 different applications. The last application we will create will be a fully fledged app with Firebase integration together with authentication and storage. In this chapter we create business logics (or blocs) with RxDart. To be clear, we are not using the Bloc package at all in this chapter. Bloc is a term generally used as an abbreviation of business logic so you don't need to know about the Bloc package in order to learn this chapter.

# Examples

| Name                          | Description                  | Points                                                       | Demo                                                         |
| ----------------------------- | ---------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Example1 (With flutter_hooks) | RxDart getting started       | BehaviorSubject, distinct(), debounceTime()                  | ![rxdart-example1](.README.assets/rxdart-example1.gif)       |
| Example2                      | Search App with BloC Pattern | BloC Pattern, Rx.fromCallable(), delay(), startWith(), onErrorReturnWith() | <img src=".README.assets/rxdart-example2.gif" alt="example2"/> |
| Example3                      |                              | combineLatest()                                              | TODO: A filterable shop list with some switch buttons        |
| Example4                      |                              | take(), concat(), also see switchMap()                       | TODO: Call a  API with param that produced by anthoer API's result |
| Example5                      |                              | merge()                                                      | TODO: Build a message list from two or more users            |
| Example6                      |                              |                                                              |                                                              |
| Example7                      |                              |                                                              |                                                              |

# Source Code

Checkout [youtube-course-rxdart](https://github.com/vandadnp/youtube-course-rxdart) repository of this course by [Vandad Nahavandipoor](https://www.youtube.com/@VandadNP)

