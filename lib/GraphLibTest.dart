import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odlingino_flutter_edition/theme/CustomColors.dart';
import 'package:rive/rive.dart';

import 'Data.dart';
import 'Utils.dart';

class LineChartWidget extends StatefulWidget {
  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  //late RiveAnimationController controller;
  late List<Color> gradientColors;
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late LineChart currentChart;
  String selectedID = "1";
  late List<DropdownMenuItem<String>> dateMenuItems;
  late List<LineChart> chartList;
  late List<Data> serverData;
  List<DateTime> dateList =
      Utils.getDaysInBetween(DateTime.utc(2021, 9), DateTime.now());
  late Widget body;
  late Timer timer;
  bool mainBuildBool = false;

  @override
  void initState() {
    //load data here
    /*
    body = getAnimView();

    sendRequest(
    call async(
    runOnUiThread(run(
    mainBuildBool = true
    )))




    */
    body = getAnimView();
    //make this so that once data is recieved the animation stops and set mainBuildBool to true
    timer = Timer(Duration(seconds: 2), () {
      mainBuildBool = true;
      timer.cancel();

      setState(() {
        body = getMainView();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dev.log(mainBuildBool.toString());
    if (mainBuildBool) {
      body = getMainView();
    } else {
      body = getAnimView();
    }

    gradientColors = [CustomColors.green, CustomColors.primaryColor];
    serverData = loadData(selectedDate);
    currentChart = LineChart(
      mainData(serverData),
      swapAnimationDuration: const Duration(milliseconds: 500), // Optional
      swapAnimationCurve: Curves.easeInOutCubic, // Optional
    );

    dateMenuItems = [];
    for (DateTime date in dateList) {
      dateMenuItems.add(DropdownMenuItem(
          value: DateFormat('yyyy-MM-dd').format(date),
          child: Text(DateFormat('yyyy-MM-dd').format(date))));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedDate),
      ),
      body: body,
    );
  }

  LineChartData mainData(List<Data> dataList) {
    List<FlSpot> spotList1 = convertToSpots(dataList);

    return LineChartData(
        minX: 0,
        maxX: 24,
        minY: 0,
        maxY: 100,
        gridData: getGridData(),
        titlesData: getTitlesData(),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: CustomColors.gridColor, width: 1),
        ),
        lineBarsData: [
          getLineChartBarData(spotList1),
          //can add more LineChartBarData-objects
        ]);
  }

  FlGridData getGridData() {
    return FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: CustomColors.gridColor,
            strokeWidth: 1,
          );
        },
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: CustomColors.gridColor,
            strokeWidth: 1,
          );
        });
  }

  FlTitlesData getTitlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 6:
              return '06:00';
            case 12:
              return '12:00';
            case 18:
              return '18:00';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          if (value % 20 == 0) {
            return value.floor().toString();
          } else {
            return '';
          }
        },
        reservedSize: 32,
        margin: 12,
      ),
    );
  }

  BarAreaData getBarAreaData() {
    return BarAreaData(
        show: true,
        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList());
  }

  List<FlSpot> convertToSpots(List<Data> dataList) {
    List<FlSpot> spotList = [];
    for (Data data in dataList) {
      spotList.add(FlSpot(data.time.toDouble(), data.val));
    }
    return spotList;
  }

  getLineChartBarData(List<FlSpot> spotList) {
    return LineChartBarData(
      isCurved: true,
      barWidth: 5,
      colors: gradientColors,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: getBarAreaData(),
      spots: spotList,
    );
  }

  List<DropdownMenuItem<String>> get dropdownIDItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text("Light"), value: "1"),
      DropdownMenuItem(child: Text("Moisture"), value: "2"),
      DropdownMenuItem(child: Text("Temp"), value: "3"),
      DropdownMenuItem(child: Text("Temp 2"), value: "4"),
      DropdownMenuItem(child: Text("Moist 2"), value: "5"),
    ];
    return menuItems;
  }

  List<Data> loadData(String date) {
    //send request and return values from specific "date".

    List<Data> dataList = [];
    Random rng = Random();
    for (int i = 0; i < 25; i++) {
      dataList.add(Data(
          i, (rng.nextDouble() * 100).clamp(10 + i.toDouble(), 25 + i * 3)));
    }
    return dataList;
  }

  RiveAnimation getAnimView() {
    return const RiveAnimation.asset(
      'assets/runningBoy.riv',
      fit: BoxFit.fitHeight,
    );
  }

  ListView getMainView() {
    return ListView(shrinkWrap: true, children: [
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Date",
              style: TextStyle(color: CustomColors.textColor, fontSize: 20),
            ),
            const SizedBox(
              width: 20,
            ),
            DropdownButton(
                menuMaxHeight: 300,
                dropdownColor: CustomColors.bgColorAccent,
                style: TextStyle(color: CustomColors.textColor, fontSize: 18),
                items: dateMenuItems,
                value: selectedDate,
                onChanged: (String? selected) {
                  setState(() {
                    selectedDate = selected!;
                  });
                }),
          ],
        ),
      ),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Sensor",
              style: TextStyle(color: CustomColors.textColor, fontSize: 20),
            ),
            const SizedBox(
              width: 20,
            ),
            DropdownButton(
                menuMaxHeight: 300,
                dropdownColor: CustomColors.bgColorAccent,
                focusColor: CustomColors.bgColor,
                style: TextStyle(color: CustomColors.textColor, fontSize: 18),
                items: dropdownIDItems,
                value: selectedID,
                onChanged: (String? selected) {
                  setState(() {
                    selectedID = selected!;
                  });
                }),
          ],
        ),
      ),
      Center(
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: currentChart),
          ),
        ),
      ),
    ]);
  }
}
