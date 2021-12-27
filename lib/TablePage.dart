import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  @override
  State<TablePage> createState() => TablePageState();
}

class TablePageState extends State<TablePage> {
  double fs = 30;

  List<double> inputData = [];
  List<double> showData = []; // for filtering

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TablePage"),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              width: 300,
              child: TextField(
                onChanged: (String filterText) {
                  setState(() {
                    showData = [];
                    for (double d in inputData) {
                      if (d.toString().contains(filterText)) {
                        showData.add(d);
                      }
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Filter',
                  hintStyle: TextStyle(fontSize: fs),
                ),
                style: TextStyle(fontSize: fs),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                inputData = [2.4, 5, 7, 3.5, 9.6];
                showData = inputData;
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: const Text(
                "Load InputStream as a list",
                style: TextStyle(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: showData.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        showData.removeAt(index);
                      });
                    },
                    title: Text(showData[index].toString()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
