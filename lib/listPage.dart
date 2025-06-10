import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final List<Map<String, String>> _items = [];


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var titleStyle = TextStyle(
      fontSize: 30.0,
    );
    var numberStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontSize: 30.0,
    );
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: _itemController,
                    decoration: InputDecoration(
                      labelText: "Item",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: "Quantity",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      String item = _itemController.text.trim();
                      String quantity = _quantityController.text.trim();
                      if (item.isNotEmpty && quantity.isNotEmpty) {
                        _items.add({'item': item, 'quantity': quantity});
                        _itemController.clear();
                        _quantityController.clear();
                      }
                    });
                  },
                  child: Text("Add"),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 16),
            Flexible(
              child:
              _items.isEmpty
                  ? Center(child: Text("There are no items in the list"))
                  : ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                          title: Text("Delete item"),
                          content: Text(
                            "Do you want to delete this item?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _items.removeAt(index);
                                });
                                Navigator.pop(context);
                              },
                              child: Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${index + 1}: ${_items[index]['item']}"),
                        Text("  "),
                        Text("quantity: ${_items[index]['quantity']}"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
