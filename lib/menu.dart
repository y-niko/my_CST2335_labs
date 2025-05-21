import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget buildStackWithTextMiddle(String img, String text) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CircleAvatar(radius: 50, backgroundImage: AssetImage(img)),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildTitleRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildStack(String img, String text) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(img),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildTitleRow("BROWSE CATEGORIES"),
            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                    ),
                  ),
                ),
              ],
            ),
            buildTitleRow("BY MEAT"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildStack("images/beef.jpg", "BEEF"),
                buildStack("images/chicken.jpg", "CHICKEN"),
                buildStack("images/pork.jpg", "PORK"),
                buildStack("images/seafood.jpg", "SEAFOOD"),
              ],
            ),
            buildTitleRow("BY COURSE"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildStackWithTextMiddle("images/main-dish.jpg", "Main Dishes"),
                buildStackWithTextMiddle("images/salad.jpg", "Salad Recipes"),
                buildStackWithTextMiddle("images/side-dish.jpg", "Side Dishes"),
                buildStackWithTextMiddle("images/crockpot.jpg", "Crockpot"),
              ],
            ),
            buildTitleRow("BY DESSERT"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildStackWithTextMiddle("images/ice-cream.jpg", "Ice Cream"),
                buildStackWithTextMiddle("images/brownies.jpg", "Brownies"),
                buildStackWithTextMiddle("images/pie.jpg", "Pies"),
                buildStackWithTextMiddle("images/cookie.jpg", "Cookies"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
