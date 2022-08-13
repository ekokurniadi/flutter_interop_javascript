import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Javascript Native'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// INFO : DEFINE JAVASCRIPT OBJECT
  late js.JsObject state;
  @override
  void initState() {
    /// INFO : THIS EXAMPLE I WANT TO SHOW
    /// HOW SHOW PUSH NOTIFICATION ON FLUTTER WEB
    /// FIRST : CALL METHOD FROM DART TO JAVASCRIPT FUNCTION
    /// THIS FUNCTION TO REQUEST PERMISSION NOTIFICATION ON YOUR BROWSER
    /// YOU CAN FIND THIS METHOD ON WEB/APP.JS
    js.context.callMethod('allowPermission');

    /// INFO : INITIAL JAVASCRIPT OBJECT AND LINKING TO NATIVE OBJECT JAVASCRIPT
    state = js.JsObject.fromBrowserObject(js.context['state']);
    state['counter'] = 0;
    super.initState();
  }

  void _incrementCounter() {
    /// SET VALUE OF JAVASCRIPT OBJECT FROM DART
    /// THE OBJECT HAVE 4 FIELD = TITLE, BODY, ICON, AND COUNTER

    state['title'] = "Notification Title";
    state['body'] = "Text your notification body here";

    /// in real project you can pass icon dynamically using rootBundle assets
    state['icon'] = "./icons/Icon-192.png";

    /// passing value state counter to variable increment
    state['counter'];

    /// you will also can pass argument on call method
    /// example : [context.callMethod('yourFunctionHere',[your argument here])]
    js.context.callMethod('showNotification');

    /// set state using for update widget
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "${state['counter']}",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
