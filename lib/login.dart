import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';


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
  final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();

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
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loadSavedCredentials() async {
    final savedUsername = await _prefs.getString('username');
    final savedPassword = await _prefs.getString('password');

    if (savedUsername != null && savedUsername.isNotEmpty && savedPassword != null && savedPassword.isNotEmpty) {
      _nameController.text = savedUsername;
      _passwordController.text = savedPassword;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loaded saved username and password.')),
      );
    }
  }

  void _loginPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Save Login Info"),
          content: Text("Would you like to save your login info?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () async {
                await _prefs.remove('username');
                await _prefs.remove('password');
                Navigator.of(context).pop();
                _handleLoginLogic();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                await _prefs.setString('username', _nameController.text);
                await _prefs.setString('password', _passwordController.text);
                Navigator.of(context).pop();
                _handleLoginLogic();
              },
            ),
          ],
        );
      },
    );
  }

  void _handleLoginLogic() {
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
    var numberStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: myFontSize);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              onPressed: _loginPressed,
              child: Text("Login"),
            ),
            Image.asset(imgSource, height: 300, width: 300),
          ],
        ),
      ),
    );
  }
}

