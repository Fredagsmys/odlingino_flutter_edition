import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odlingino_flutter_edition/FirstFragment.dart';
import 'package:odlingino_flutter_edition/SecondFragment.dart';
import 'package:odlingino_flutter_edition/theme/CustomColors.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  int selectedItem = 0;



  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [FirstFragment(), SecondFragment()];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("HomePage"),
      ),
      body: IndexedStack(
        index: selectedItem,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "star"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home")
        ],currentIndex: selectedItem,
        onTap: (value){
          setState(() {
            selectedItem = value;
          });

        },
        selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(color: Colors.amberAccent, size: 40),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
