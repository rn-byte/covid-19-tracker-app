import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                PieChart(
                  dataMap: const {
                    'Recovered': 65,
                    'Infected': 30,
                    'Death': 5,
                  },
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  legendOptions:
                      const LegendOptions(legendPosition: LegendPosition.left),
                  animationDuration: const Duration(seconds: 5),
                  chartType: ChartType.ring,
                  colorList: colorList,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .06,
                  ),
                  child: Card(
                    child: Column(
                      children: [
                        ResuableRow(title: 'Total', value: '200'),
                        ResuableRow(title: 'Total', value: '200'),
                        ResuableRow(title: 'Total', value: '200'),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  // width: MediaQuery.of(context).size.width * .4,
                  decoration: BoxDecoration(
                    color: const Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('Track Countries'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
