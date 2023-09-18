import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const MyHomePage(
          uri: '',
          routeName: 'Initial',
        );
      },
      routes: [
// - The intent `adb shell am start -a android.intent.action.VIEW -d "uriParamBug://example/home"` routes correctly to 'home'.
// - The intent `adb shell am start -a android.intent.action.VIEW -d "uriParamBug://example/#/home"` fails to route to 'home'
        GoRoute(
          path: 'home',
          name: 'home',
          builder: (context, state) => MyHomePage(
            uri: state.uri.toString(),
            routeName: 'Home',
          ),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.uri, required this.routeName});

  final String uri;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(routeName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(uri),
          ],
        ),
      ),
    );
  }
}
