#  View Model Proxys

View Model proxys are state objects that are injected into Screens and handles their states. The proxy manages the data changes to their state, and in turn references the global State.

By using a view model proxy we can change the display, sorting, and CRUD of the data in a particular screen without having to change global or modify the global state object. Global state is still ultimatel taken from a global state object, but now changing the way it's presented in a particular screen doesn't require global state rewrites.

Example: List

Tasks in a list can be sorted, and resorted. They can be filtered based on hashtag, and they can be edited. Making all of these changes directly to Global State means that the global state will need to know how to make these changes. By using the proxy, only the proxy knows. Additionally, the proxy can hold convenience methods, and calculated data that is important to the particular view or screen that it supports, but that isn't important to global state. 

In our case, Global state can hold an array of all tasks, but the proxy state can hold an array of just activeTasks in a particular list. 


ViewModel proxys handle the sorting and manipulation of DATA, Not Views. Local @State should be used to handle local mutation of view state.
