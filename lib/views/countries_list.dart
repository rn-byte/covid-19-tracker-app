import 'package:covid_19_tracker_app/services/stats_services.dart';
import 'package:flutter/material.dart';

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
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  suffixIcon: Icon(
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
            ),
            Expanded(
                child: FutureBuilder(
              future: statsServices.fetchCountriesStats(),
              builder:
                  (context, AsyncSnapshot<List<CountriesStats>?> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image(
                          image: NetworkImage(
                              snapshot.data![index].countryInfo.flag),
                          height: 40,
                          width: 40,
                        ),
                        title: Text(snapshot.data![index].country),
                        subtitle:
                            Text('Deaths: ${snapshot.data![index].deaths}'),
                      );
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
}
