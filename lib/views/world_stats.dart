import 'package:covid_19_tracker_app/views/countries_list.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../services/stats_services.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  StatsServices statsServices = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                FutureBuilder(
                  future: statsServices.fetchWorldStats(),
                  builder:
                      (context, AsyncSnapshot<Map<String, double>?> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator()
                          // SpinKitFadingCircle(
                          //   color: Colors.black,
                          //   size: 50.0,
                          //   controller: _controller,
                          // ),
                          );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total': double.parse(
                                  snapshot.data!['cases'].toString()),
                              'Recovered': double.parse(
                                  snapshot.data!['recovered'].toString()),
                              'Death': double.parse(
                                  snapshot.data!['deaths'].toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration: const Duration(seconds: 5),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06,
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  ResuableRow(
                                      title: 'Total',
                                      value:
                                          snapshot.data!['cases'].toString()),
                                  ResuableRow(
                                      title: 'Recovered',
                                      value: snapshot.data!['recovered']
                                          .toString()),
                                  ResuableRow(
                                      title: 'Death',
                                      value:
                                          snapshot.data!['deaths'].toString()),
                                  ResuableRow(
                                      title: 'Active',
                                      value:
                                          snapshot.data!['active'].toString()),
                                  ResuableRow(
                                      title: 'Critical',
                                      value: snapshot.data!['critical']
                                          .toString()),
                                  ResuableRow(
                                      title: 'Today Deaths',
                                      value: snapshot.data!['todayDeaths']
                                          .toString()),
                                  ResuableRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!['todayRecovered']
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CountriesListScreen(),
                                  ));
                            },
                            child: Container(
                              height: 50,
                              // width: MediaQuery.of(context).size.width * .4,
                              decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ResuableRow extends StatelessWidget {
  String title, value;

  ResuableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
        right: 10,
        bottom: 5,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
