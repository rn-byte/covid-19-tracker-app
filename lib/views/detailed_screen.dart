import 'package:covid_19_tracker_app/views/world_stats.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailedScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailedScreen({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ResuableRow(
                          title: 'Total Cases',
                          value: widget.totalCases.toString()),
                      ResuableRow(
                          title: 'Total Deaths',
                          value: widget.totalDeaths.toString()),
                      ResuableRow(
                          title: 'Total Recovered',
                          value: widget.todayRecovered.toString()),
                      ResuableRow(
                          title: 'Active', value: widget.active.toString()),
                      ResuableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ResuableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString()),
                      ResuableRow(
                          title: 'Tests', value: widget.test.toString()),
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: 105,
              //   width: 105,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: NetworkImage(widget.image),
              //     ),
              //     // color: Colors.blue,
              //     borderRadius: BorderRadius.circular(52.5),
              //   ),
              // )
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
    );
  }
}
