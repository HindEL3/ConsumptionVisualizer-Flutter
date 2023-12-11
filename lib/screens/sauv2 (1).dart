import 'dart:developer';
import 'dart:ffi';
import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  double avgT = 0;
  double avgF = 0;
  double d00 = 0;
  double d11 = 0;
  double d22 = 0;
  double d33 = 0;
  double d44 = 0;
  List<List<dynamic>> data = [];
  List<ChartData> chartData = [];

  late List<charts.Series<Stockval, String>> _seriesDatan = [];

  late List<charts.Series<Captermemory, int>> _seriesLineData = [];

  //late List<charts.Series<Sales, int>> _seriesLineData=[];
  late List<charts.Series<Capter, String>> _seriesPieDatan = [];
  //generate data
  _generateData(List<List> data) async {
    
    loadCSV();
    //await Future.delayed(Duration(seconds: 5));

    var colors = [
      new Color(0xff990099),
      new Color(0xff3366cc),
      new Color(0xFFFFCDD2),
      new Color(0xFFD7CCC8),
      new Color(0xFFB2EBF2),
      new Color(0xFFFFCCBC),
      new Color(0xFFD1C4E9),
      new Color(0xFFC8E6C9),
      new Color(0xFFFFE0B2),
      new Color(0xFFF8BBD0),
      new Color(0xFFFFCDD2),
      new Color(0xFFFFEA00),
    ];

    final rawData = await rootBundle.loadString("assets/Consommation.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    // var result = data[1].map((m) => m).reduce((a, b) => a + b) / data[1].length;
    // print(result.toString());
    // print(result.toString());
    // print(result.toString());
    // print(result.toString());
    List<Stockval> data1 = [];
    List<Stockval> data2 = [];
    List<Stockval> data3 = [];
    List<Stockval> data4 = [];

    setState(() {
      double sum1 = 0;
      double sum2 = 0;
      double sum3 = 0;
      double sum4 = 0;

      double ifF = 0;
      double ifT = 0;

      data = listData;
      for (var i = 1; i < data.length; i++) {
        sum1 += data[i][1];
      }
      d00 = sum1 / (data.length - 1);

      for (var i = 1; i < data.length; i++) {
        sum2 += data[i][2];
      }
      d11 = sum2 / (data.length - 1);

      for (var i = 1; i < data.length; i++) {
        sum3 += data[i][3];
      }
      d22 = sum3 / (data.length - 1);

      for (var i = 1; i < data.length; i++) {
        sum4 += data[i][4] == "" ? 0 : data[i][4];
      }
      d33 = sum4 / (data.length - 1);

      for (var i = 1; i < data.length; i++) {
        if (data[i][5] == "FALSE") {
          ifF += 1;
        } else {
          ifT += 1;
        }
      }
      data1 = [
        new Stockval(2020, 'المتراكم', d00.toInt()),
      ];
      data2 = [
        new Stockval(2021, 'اليومي', d11.toInt()),
      ];
      data3 = [
        new Stockval(2022, '2:00AM To 6:00AM', d22.toInt()),
      ];
      data4 = [
        new Stockval(2023, 'شهري', d33.toInt()),
      ];
      avgT = ifT / (data.length - 1);
      avgF = ifF / (data.length - 1);

      // var x = data[1].fold(1, (previousValue, element) => previousValue);
      // print(x);
    });

    String s0 = data[0][1].toString();
    int d0 = d00.toInt();
    Capter c0 = new Capter(s0, d0, colors[0]);

    String s1 = data[0][2].toString();
    int d1 = d11.toInt();
    Capter c1 = new Capter(s1, d1, colors[1]);

    String s2 = data[0][3].toString();
    int d2 = d22.toInt();
    Capter c2 = new Capter(s2, d2, colors[2]);

    String s3 = data[0][4].toString();
    int d3 = d33.toInt();
    Capter c3 = new Capter(s3, d3, colors[3]);

    // String s4=data[0][5].toString();
    // double d4 = double.parse(data[5][2].toString());
    // Capter c4=new Capter(s4, d4, colors[4]);

    // String s5=data[0][1].toString();
    // double d5 = double.parse(data[6][2].toString());
    // Capter c5=new Capter(s5, d5, colors[5]);

    late var piedatan = [
      c0, c1, c2, c3,
      //new Capter(3,'zag', 54, Color(0xff3366cc)),
      //new Capter(0,data[1][1].toString(), data[1][2], Color(0xff3366cc)),
      //new Capter(1,data[2][1].toString(), data[2][2], Color(0xff3366cc)),
      //new Capter(2,data[3][1].toString(), data[3][2], Color(0xff3366cc)),
      //new Capter(3,data[4][1].toString(), data[4][2], Color(0xff3366cc)),
      //new Capter(4,data[5][1].toString(), data[5][2], Color(0xff3366cc)),
      //new Capter(5,data[6][1].toString(), data[6][2], Color(0xff3366cc)),
      //new Task(data[2][0].toString(), data[2][1], colors[1]),
      //new Task(data[1][0].toString(), data[][1], colors[1]),
      //new Task(data[1][0].toString(), data[1][1], colors[1]),
      //new Task(data[1][0].toString(), data[1][1], colors[1]),
      //new Task(data[1][0].toString(), data[1][1], colors[1]),
    ];

    //Captermemory
    var linesalesdata = [
      new Captermemory('Berlin', 0, 23),
      new Captermemory('Berlin', 1, 36),
      new Captermemory('Berlin', 2, 30),
      new Captermemory('Berlin', 3, 12),
      new Captermemory('Berlin', 4, 18),
      new Captermemory('Berlin', 5, 19),
    ];
    var linesalesdata1 = [
      new Captermemory('Köln', 0, 35),
      new Captermemory('Köln', 1, 32),
      new Captermemory('Köln', 2, 19),
      new Captermemory('Köln', 3, 20),
      new Captermemory('Köln', 4, 21),
      new Captermemory('Köln', 5, 19),
    ];
    var linesalesdata2 = [
      new Captermemory('Düsseldorf', 0, 34),
      new Captermemory('Düsseldorf', 1, 24),
      new Captermemory('Düsseldorf', 2, 12),
      new Captermemory('Düsseldorf', 3, 40),
      new Captermemory('Düsseldorf', 4, 34),
      new Captermemory('Düsseldorf', 5, 33),
    ];

    //CapterStock
    _seriesDatan.add(
      charts.Series(
        domainFn: (Stockval stockval, _) => stockval.place,
        measureFn: (Stockval stockval, _) => stockval.quantity,
        id: '2020',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Stockval stockval, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );
    _seriesDatan.add(
      charts.Series(
        domainFn: (Stockval stockval, _) => stockval.place,
        measureFn: (Stockval stockval, _) => stockval.quantity,
        id: '2021',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Stockval stockval, _) =>
            charts.ColorUtil.fromDartColor(colors[3]),
      ),
    );
    _seriesDatan.add(
      charts.Series(
        domainFn: (Stockval stockval, _) => stockval.place,
        measureFn: (Stockval stockval, _) => stockval.quantity,
        id: '2022',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Stockval stockval, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesDatan.add(
      charts.Series(
        domainFn: (Stockval stockval, _) => stockval.place,
        measureFn: (Stockval stockval, _) => stockval.quantity,
        id: '2022',
        data: data4,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Stockval stockval, _) =>
            charts.ColorUtil.fromDartColor(colors[4]),
      ),
    );

    _seriesPieDatan.add(
      charts.Series(
        domainFn: (Capter capter, _) => capter.localisation,
        measureFn: (Capter capter, _) => capter.value,
        colorFn: (Capter capter, _) =>
            charts.ColorUtil.fromDartColor(capter.colorval),
        id: 'Air Pollution',
        data: piedatan,
        labelAccessorFn: (Capter row, _) => '${row.value}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Capters memory',
        data: linesalesdata,
        domainFn: (Captermemory captermemory, _) => captermemory.yearval,
        measureFn: (Captermemory captermemory, _) => captermemory.value,
        labelAccessorFn: (Captermemory row, _) => '${row.localisation}',
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Capters memory',
        data: linesalesdata1,
        domainFn: (Captermemory captermemory, _) => captermemory.yearval,
        measureFn: (Captermemory captermemory, _) => captermemory.value,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Capters memory',
        data: linesalesdata2,
        domainFn: (Captermemory captermemory, _) => captermemory.yearval,
        measureFn: (Captermemory captermemory, _) => captermemory.value,
      ),
    );
  }

  // This function is triggered when the floating button is pressed
  void loadCSV() async {
    final rawData = await rootBundle.loadString("assets/Consommation.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    setState(() {
      data = listData;
      print(data.last[5] + data[29][5] + data[28][5]);

      setState(() {
        chartData = <ChartData>[
          ChartData(5, data[1][1], data[1][2], data[1][3],
              data[1][4].toString() == "" ? 0 : data[1][4]),
          ChartData(10, data[5][1], data[5][2], data[5][3],
              data[5][4].toString() == "" ? 0 : data[5][4]),
          ChartData(15, data[9][1], data[9][2], data[9][3],
              data[9][4].toString() == "" ? 0 : data[9][4]),
          ChartData(20, data[13][1], data[13][2], data[13][3],
              data[13][4].toString() == "" ? 0 : data[13][4]),
          ChartData(27, data[17][1], data[17][2], data[17][3],
              data[17][4].toString() == "" ? 0 : data[17][4]),
          ChartData(30, data[30][1], data[30][2], data[30][3],
              data[30][4].toString() == "" ? 0 : data[30][4]),
          ChartData(30, data[30][1], data[30][2], data[30][3],
              data[30][4].toString() == "" ? 0 : data[30][4]),
        ];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadCSV();
    _seriesDatan = List<charts.Series<Stockval, String>>.from(
        <charts.Series<Stockval, String>>[]);
    _seriesLineData = List<charts.Series<Captermemory, int>>.from(
        <charts.Series<Captermemory, String>>[]);
    _seriesPieDatan = List<charts.Series<Capter, String>>.from(
        <charts.Series<Capter, String>>[]);
    _generateData(data);

  }

  @override
  Widget build(BuildContext context) {
                      if (data.last[5] == "TRUE" ||
        data[29][5] == "TRUE" ||
        data[28][5] == "TRUE") {
      Future.delayed(
          Duration(milliseconds: 500),
          () => Alert(
                context: context,
                type: AlertType.warning,
                title: "! " + "هناك تسريب مياه",
                buttons: [
                  DialogButton(
                    child: Text(
                      "حسنا",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show());
    }
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                // Tab(
                //   icon: Icon(FontAwesomeIcons.solidChartBar),
                // ),
                // Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Flutter Charts'),
          ),
          body: TabBarView(
            children: [
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Container(
              //     child: Center(
              //       child: Column(
              //         children: <Widget>[
              //           Text(
              //             'Graph representing average of data coming from capters',
              //             style: TextStyle(
              //                 fontSize: 24.0, fontWeight: FontWeight.bold),
              //           ),
              //           SizedBox(
              //             height: 10.0,
              //           ),
              //           Expanded(
              //             child: _seriesPieDatan.isEmpty
              //                 ? Center(
              //                     child: CircularProgressIndicator(),
              //                   )
              //                 : charts.PieChart(_seriesPieDatan,
              //                     animate: true,
              //                     animationDuration: Duration(seconds: 3),
              //                     behaviors: [
              //                       new charts.DatumLegend(
              //                         outsideJustification: charts
              //                             .OutsideJustification.endDrawArea,
              //                         horizontalFirst: false,
              //                         desiredMaxRows: 2,
              //                         cellPadding: new EdgeInsets.only(
              //                             right: 4.0, bottom: 4.0),
              //                         entryTextStyle: charts.TextStyleSpec(
              //                             color: charts.MaterialPalette.purple
              //                                 .shadeDefault,
              //                             fontFamily: 'Georgia',
              //                             fontSize: 11),
              //                       )
              //                     ],
              //                     defaultRenderer: new charts.ArcRendererConfig(
              //                         arcWidth: 100,
              //                         arcRendererDecorators: [
              //                           new charts.ArcLabelDecorator(
              //                               labelPosition:
              //                                   charts.ArcLabelPosition.inside)
              //                         ])),
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //               Text(
              //                 '%نسبة حدوث تسرب : ${avgT * 100}',
              //                 style: TextStyle(
              //                     fontSize: 15.0, fontWeight: FontWeight.bold),
              //               ),
              //               Text(
              //                 '%نسبة عدم حدوث تسرب : ${avgF * 100}',
              //                 style: TextStyle(
              //                     fontSize: 15.0, fontWeight: FontWeight.bold),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Container(
              //     child: Center(
              //       child: Column(
              //         children: <Widget>[
              //           Text(
              //             'Average of Consumption',
              //             style: TextStyle(
              //                 fontSize: 24.0, fontWeight: FontWeight.bold),
              //           ),
              //           Expanded(
              //             child: charts.BarChart(
              //               _seriesDatan,
              //               animate: true,
              //               barGroupingType: charts.BarGroupingType.grouped,
              //               //behaviors: [new charts.SeriesLegend()],
              //               animationDuration: Duration(seconds: 3),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text("لتر ${data.last[1]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Spacer(),
                            Text("استهلاك المياه التراكمي",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Container(
                            child: SfCartesianChart(
                                title: ChartTitle(
                                    text:
                                        'Average consumption per day for a month',
                                    backgroundColor: Colors.lightGreen,
                                    borderColor: Colors.blue,
                                    borderWidth: 2,
                                    // Aligns the chart title to left
                                    alignment: ChartAlignment.near,
                                    textStyle: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Roboto',
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                    )),
                                legend: Legend(
                                    isVisible: true,
                                    // Overflowing legend content will be wraped
                                    overflowMode: LegendItemOverflowMode.wrap),
                                series: <CartesianSeries<ChartData, int>>[
                              LineSeries<ChartData, int>(
                                  name: 'المتراكم',
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) =>
                                      data.series0),
                              LineSeries<ChartData, int>(
                                  name: 'اليومي',
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) =>
                                      data.series1),
                              LineSeries<ChartData, int>(
                                  name: '2:00AM To 6:00AM',
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) =>
                                      data.series2),
                              LineSeries<ChartData, int>(
                                  name: 'شهري',
                                  dataSource: chartData,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) =>
                                      data.series3),
                            ])),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );

    //};
  }
}

class Stockval {
  String place;
  int year;
  int quantity;

  Stockval(this.year, this.place, this.quantity);
}

class Captermemory {
  String localisation;
  int yearval;
  int value;

  Captermemory(this.localisation, this.yearval, this.value);
}

class Capter {
  //late int id;
  late String localisation;
  late int value;
  late Color colorval;

  Capter(this.localisation, this.value, this.colorval);
}

class ChartData {
  ChartData(this.x, this.series0, this.series1, this.series2, this.series3);
  final int x;
  var series0;
  var series1;
  var series2;
  var series3;
}
