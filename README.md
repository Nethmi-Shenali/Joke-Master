# Joke Master

Joke Master is a simple Flutter app that fetches and displays jokes using an API, and caches them using the shared_preferences package. The app works in both online and offline modes. When the app is offline, it will display the cached jokes previously fetched from the API.

# Features

-Fetches jokes from an external jokes API using a GET request.

-Caches the jokes locally using the shared_preferences package for offline use.

-Displays 5 jokes each time, ensuring consistent content both online and offline.

-Handles JSON serialization/deserialization properly to parse the jokes from the API.

# Technologies Used

-Flutter: Framework for building the app.

-shared_preferences: Package used to cache jokes locally on the device.

-http: Package for making HTTP requests to fetch jokes from the API.

# How It Works
## Online Mode:

-When the app is online, it fetches jokes from a public jokes API.

-The jokes are fetched via a GET request and displayed in a list.

## Offline Mode:

-When the app is offline, it loads jokes from local storage (cache) using the shared_preferences package.

-The jokes are stored as a list of strings and are displayed when there is no internet connection.

## JSON Serialization and Deserialization
The app handles JSON serialization and deserialization to fetch jokes from the API. The jokes are fetched as a list of objects, and each joke is stored in a simple string format in the local cache.

## Demo
You can view the demo video showcasing the app's functionality, including:

-Fetching 5 jokes from the API.

-The app working offline and showing cached jokes.

Demo Video:https://drive.google.com/file/d/1BqeTno5l3QhTr5XOToHYWMQOGB4iTTZx/view?usp=sharing

