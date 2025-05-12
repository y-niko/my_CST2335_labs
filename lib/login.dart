import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  var myFontSize = 30.0;
  var imgQuestion = "images/question-mark.png";
  var imgIdea = "images/idea.png";
  var imgStop = "images/stop.png";
  var imgSource;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    imgSource = imgQuestion;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void buttonClicked() {
    if (_passwordController.text == 'QWERTY123') {
      setState(() {
        imgSource = imgIdea;
      });
    } else {
      setState(() {
        imgSource = imgStop;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(fontSize: myFontSize);
    var numberStyle = Theme
        .of(
      context,
    )
        .textTheme
        .headlineMedium
        ?.copyWith(fontSize: myFontSize);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Login name'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: buttonClicked,
              child: Text("Login"),
            ),
            Image.asset(imgSource, height: 300, width: 300,),
          ],
        ),
      ),
    );
  }
}
