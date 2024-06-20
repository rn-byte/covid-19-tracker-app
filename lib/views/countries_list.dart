import 'package:covid_19_tracker_app/services/stats_services.dart';
import 'package:covid_19_tracker_app/views/detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/countries_stats_model.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatsServices statsServices = StatsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries List'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        //margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            _textField(),
            Expanded(
                child: FutureBuilder(
              future: statsServices.fetchCountriesStats(),
              builder:
                  (context, AsyncSnapshot<List<CountriesStats>?> snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                            height: 40,
                            width: 40,
                            color: Colors.white,
                          ),
                          title: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index].country;
                      if (searchController.text.isEmpty) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailedScreen(
                                      image: snapshot
                                          .data![index].countryInfo.flag,
                                      name: snapshot.data![index].country,
                                      totalCases: snapshot.data![index].cases,
                                      totalDeaths: snapshot.data![index].deaths,
                                      totalRecovered:
                                          snapshot.data![index].recovered,
                                      active: snapshot.data![index].active,
                                      critical: snapshot.data![index].critical,
                                      todayRecovered:
                                          snapshot.data![index].todayRecovered,
                                      test: snapshot.data![index].tests),
                                ));
                          },
                          child: ListTile(
                            leading: Image(
                              image: NetworkImage(
                                  snapshot.data![index].countryInfo.flag),
                              height: 40,
                              width: 40,
                            ),
                            title: Text(snapshot.data![index].country),
                            subtitle:
                                Text('Cases : ${snapshot.data![index].cases}'),
                          ),
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailedScreen(
                                      image: snapshot
                                          .data![index].countryInfo.flag,
                                      name: snapshot.data![index].country,
                                      totalCases: snapshot.data![index].cases,
                                      totalDeaths: snapshot.data![index].deaths,
                                      totalRecovered:
                                          snapshot.data![index].recovered,
                                      active: snapshot.data![index].active,
                                      critical: snapshot.data![index].critical,
                                      todayRecovered:
                                          snapshot.data![index].todayRecovered,
                                      test: snapshot.data![index].tests),
                                ));
                          },
                          child: ListTile(
                            leading: Image(
                              image: NetworkImage(
                                  snapshot.data![index].countryInfo.flag),
                              height: 40,
                              width: 40,
                            ),
                            title: Text(snapshot.data![index].country),
                            subtitle:
                                Text('Cases : ${snapshot.data![index].cases}'),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Padding _textField() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {});
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          prefixIcon: Icon(
            Icons.search,
          ),
          hintText: 'Search with country name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
