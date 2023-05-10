import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp()); //Starts the app
}

// Sets up the whole app.  It creates the app-wide state, names the app, defines the visual theme, and sets the "home" widget—the starting point of your app.
class MyApp extends StatelessWidget {
  // Widgets are the elements from which you build every Flutter app.

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // This allows any widget in the app to get hold of the state.
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// Defines the app state
class MyAppState extends ChangeNotifier {
  //means that it can notify others about its own changes.
  var current = WordPair.random();
  // getNext() method reassigns current with a new random WordPair. It also calls notifyListeners()(a method of ChangeNotifier)that ensures that anyone watching MyAppState is notified.
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

// Every widget defines a build() method. Every build method must return a widget or (more typically) a nested tree of widgets.
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<
        MyAppState>(); // tracks changes to the app's current state using the watch method.
    var pair = appState.current;

    return Scaffold(
      // top-level widget
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // This centers the children inside the Column along its main (vertical) axis
        // Column is one of the most basic layout widgets in Flutter.
        children: [
          Text('A random AWESOME idea:'),
          BigCard(pair: pair),
          ElevatedButton(
            onPressed: () {
              appState.getNext(); // ← This instead of print().
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ↓ Add this.
    final style = theme.textTheme.displayMedium!.copyWith(
      //To get the full list of properties you can change: Cmd+Shift+Space
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        // ↓ Change this line.
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
