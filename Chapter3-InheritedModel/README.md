# testinginheritedmodel_course

A new Flutter project.

## Getting Started

In this chapter we will talk about InheritedModel in Flutter and how it is different from InheritedWidget. InheritedModel has a constant constructor meaning that your subclasses will also need to be constants. But how can they have state when they are constants? Well, you need to have a StatefulWidget that wraps around your InheritedModel. The stateful widget will hold onto the state and pass it to the InheritedModel! Learn all about that and more in this chapter.
