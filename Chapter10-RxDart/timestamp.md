Intro:

https://www.youtube.com/watch?v=xBFWMYmm9ro&list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&index=12&t=0s



Streams:

Observables in Rx is Streams in RxDart

https://www.youtube.com/watch?v=xBFWMYmm9ro&list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&index=12&t=765s



example 1:

BehaviorSubject, distinct(), debounceTime()

https://www.youtube.com/watch?v=xBFWMYmm9ro&list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&index=12&t=1095s



What are Rx operators?

It's just playing with values that are asynchronously produced on a stream or a  pipe. 

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=2614



RxMarbles (Interactive diagrams of Rx Observables)

https://www.youtube.com/watch?v=xBFWMYmm9ro&list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=2883s



Rx Documentation

https://www.youtube.com/watch?v=xBFWMYmm9ro&list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=3348s



example 2:

> Don't forget to start Live Server

BloC Pattern, Rx.fromCallable(), delay(), startWith(), onErrorReturnWith()

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=3485



example 3:

combineLatest()

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=8514



example 4:

concat()

`concat()` usually used when you want to call APIs after each one, just do second API after first API finished, and do a third API after second API finished, and more. Which called APIs without any params

**more:** If you want to call APIs  by passing some params that provided by previous API, `switchMap()` could be better.

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=9692



example 5:

merge()

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=10497



example 6:

zip()

It works with indexes of all observables.

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=10904



example 7:

switchMap()

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=11623



Difference between `flatMap` and `switchMap`

> `flatMap` doesn't dispose of the subscription from the previous mapping that still keeps going, but `siwtchMap` as it likes in some Rx implementations as soon as the new value produced in the source stream and the result stream will be re-start based on the new value from source stream.
>
> [Difference Between Flatmap and Switchmap in Rxjava](https://www.baeldung.com/rxjava-flatmap-switchmap)

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=12344



Rx is really about pipes of data

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=12400



example 8:

Display a list of "things", and filter them using a FilterChip with BloC pattern (Flutter 3.3.10)

BloC Pattern, StreamBuilder,  BehaviorSubject, debounceTime(), map(), startWith()

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=12483



example 9:

https://youtu.be/xBFWMYmm9ro?list=PL6yRaaP0WPkUf-ff1OX99DVSL1cynLHxO&t=14279
