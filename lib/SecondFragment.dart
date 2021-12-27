import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odlingino_flutter_edition/theme/CustomColors.dart';

class SecondFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                tabs: [
                  Tab(
                    text: 'Incoming',
                  ),
                  Tab(
                    text: 'Outgoing',
                  ),
                  Tab(
                    text: 'Missed',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IncomingPage(),
            OutgoingPage(),
            MissedPage(),
          ],
        ),
      ),
    );
  }
}

class IncomingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text("incomming");
  }

}

class OutgoingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text("outgoing");
  }

}

class MissedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Text("missed");
  }

}