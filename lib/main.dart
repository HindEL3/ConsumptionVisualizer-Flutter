/*import 'package:flutter/material.dart';

import 'TABLELAYOUT1.dart';


void main() => runApp(MaterialApp(
  home: myApp(),
));
class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TableLayout(),

    );
  }
}
*/
////////
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:csv/csv.dart';
import 'screens/DATALOAD1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //debugShowCheckedModeBanner: false,
      //title: 'Reading capter values from csv file',
      // Calling HomePage() from DATALOAD1.dart
      home: HomePage(),
    );
  }
}


