import 'package:flutter/material.dart';
import 'package:flutter_restapi_countries/app/data/models/country.dart';
import 'package:flutter_restapi_countries/app/data/services/country_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Country>? countries;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    final countryService = CountryService();
    countries = await countryService.getAllCountries();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Countries With Rest API'),
        ),
      ),
      body: isLoaded && countries != null
          ? SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Expanded(
                          child: Text('Name', textAlign: TextAlign.center)),
                      Expanded(
                          child: Text('Capital', textAlign: TextAlign.center)),
                      Expanded(
                          child:
                              Text('Continent', textAlign: TextAlign.center)),
                      Expanded(
                          child: Text('Flag', textAlign: TextAlign.center)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: countries!
                              .map(
                                (country) => Column(
                                  children: [
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(country.name?.common ??
                                                'No name')),
                                        Expanded(
                                          child: Text(country.capital != null &&
                                                  country.capital!.isNotEmpty
                                              ? country.capital!.first
                                              : 'No capital'),
                                        ),
                                        Expanded(
                                          child: Text(country.continents !=
                                                      null &&
                                                  country.continents!.isNotEmpty
                                              ? country.continents!.first
                                              : 'No continents'),
                                        ),
                                        Expanded(
                                            child: country.flags != null &&
                                                    country.flags!.png != null
                                                ? Image.network(
                                                    country.flags!.png!)
                                                : const Icon(
                                                    Icons.flag_rounded)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    const Divider(),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
