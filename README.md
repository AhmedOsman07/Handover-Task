# handover

A new Flutter project.

## Getting Started

json files in assets was created using https://developers.google.com/maps/documentation/routes/demo
each json files contains pickup and devliery json object.
from point a to b was added as pickup route
from point b to c was added as delivery route
----

## concept of how it works

the app is connected to firebase where background service( another isolate ) reads from json and
updates firebase object with index.
in same isolate there is a firebase listener to stream where it listens to updates of driver track
and transmit it to ui isolate.
this way if the app is in background it will still fetch location updates and show notifications.

## third party libs used

firebase to act as backend
flutter_local_notifications to send local notifications
geolocator to detect distance between points
get_it as service locater
flutter_bloc for state management
build_runner, freezed_annotation for generating objects
google_maps_flutter for google maps
google_fonts for styling fonts
flutter_rating_bar for rating bar



## Important note

please note on ios it might crash as there's an issue with using different isolates and firebase together
https://github.com/firebase/flutterfire/issues/6155
there's a workaround added as answer but its only applied on my machine and didnt have time to fork repo to change it
so for android platform i use streams but for ios i use peridoic timer with fetch to update cordiantes to overcome this issue
