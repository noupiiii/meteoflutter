import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteoflutter/models/weather_model.dart';
import 'package:meteoflutter/pages/city_pages.dart';
import 'package:meteoflutter/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  final String cityName;
  final List<String> cities;

  const WeatherPage({Key? key, required this.cityName, required this.cities}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("8fc7285805aac591a370d856a5194ad5"); // Replace with your actual API key
  Weather? _weather;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Clé globale pour le Scaffold

  _fetchWeather(String cityName) async {
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  void _openAddCityModal(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Nom de la ville",
                  hintText: "Entrez le nom d'une ville",
                ),
              ),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  setState(() {
                    widget.cities.add(_controller.text);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Utilisez la clé globale ici
      appBar: AppBar(
        title: Text('Météo'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _openAddCityModal(context); // Ouvrez la modal pour ajouter une ville.
            },
          ),
          IconButton(
            icon: Icon(Icons.location_city),
            onPressed: () {
              print('cities: ${widget.cities}');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CityPage(cities: widget.cities))); // Naviguez vers la page des villes.
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Chargement de la ville..."),
            Text('${_weather?.temperature.round()}°C'),
          ],
        ),
      ),
    );
  }
}