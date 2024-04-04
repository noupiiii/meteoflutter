import 'package:flutter/material.dart';
import 'package:meteoflutter/pages/weather_page.dart';

class CityPage extends StatelessWidget {
  final List<String> cities;

  const CityPage({Key? key, required this.cities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('cities: $cities');
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des villes'),
      ),
      body: cities.isEmpty
          ? Center(child: Text('No cities found'))
          : ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WeatherPage(cityName: cities[index], cities: cities),
                ),
              );
            },
          );
        },
      ),
    );
  }
}