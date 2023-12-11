import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:sauv2/screens/sauv2%20(1).dart';
import 'homepage.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //State
  List<List<dynamic>> data = [];
  // This function is triggered when the floating button is pressed,its import data from csv file in real time
  void loadCSV() async {
    final rawData = await rootBundle.loadString("assets/Consommation.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    setState(() {
      data = listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    //log("Index number is:");
    //log(data.length.toString());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reading capter values from csv file"),
        ),
        // Display the contents from the CSV file
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            // return Card(
            //   margin: const EdgeInsets.all(3),
            //   color: index == 0 ? Colors.amber : Colors.white,
            //    child: ListTile(
            //     leading: Container(child: Text(data[index][0].toString()),width: MediaQuery.of(context).size.width/4),
            //     title: Container(child: Text(data[index][1].toString()),width: MediaQuery.of(context).size.width/4),
            //     trailing: Container(child: Text(data[index][2].toString()),width: MediaQuery.of(context).size.width/4),
            //   ),
            // );
            return Container(
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.amber : Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(data[index][0].toString()),
                          width: MediaQuery.of(context).size.width / 6),
                      Container(
                          child: Text(data[index][1].toString(),
                              textAlign: TextAlign.left),
                          width: MediaQuery.of(context).size.width / 6),
                      Container(
                          child: Text(data[index][2].toString()),
                          width: MediaQuery.of(context).size.width / 6),
                      Container(
                          child: Text(data[index][3].toString()),
                          width: MediaQuery.of(context).size.width / 6),
                      Container(
                          child: Text(data[index][4].toString() == ""
                              ? "-"
                              : data[index][4].toString()),
                          width: MediaQuery.of(context).size.width / 6),
                      Container(
                          child: index == 0
                              ? Text(data[index][5].toString())
                              : Text(data[index][5].toString() == "FALSE"
                                  ? "لا"
                                  : "نعم"),
                          width: MediaQuery.of(context).size.width / 6),
                    ],
                  ),
                ));
          },
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
              child: const Icon(Icons.add), onPressed: loadCSV),
          SizedBox(width: 20),
          FloatingActionButton(
              child: const Icon(Icons.graphic_eq),
              onPressed: () {
                Navigator.push(
                  context,
                  //When we click on this button ,we run Home() from sauv2.dart
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }),
        ]));
  }
}
