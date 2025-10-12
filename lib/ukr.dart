import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class UkraineData {
  final String name;
  final List<dynamic> regions;

  UkraineData({required this.name, required this.regions});
}

class Region {
  final String name;
  final List<dynamic> cities;

  Region({required this.name, required this.cities});
}

class City {
  final String name;
  final String lat;
  final String lng;

  City({required this.name, required this.lat, required this.lng});
}

Future<UkraineData> loadData() async {
  final response = await http.get(Uri.parse(
      'https://gist.githubusercontent.com/alex-oleshkevich/1509c308fabab9e104b5190dab99a77b/raw/b20bd8026deec00205a57d395c0ae1f75cc387bb/ua-cities.json'));
  final jsonData = json.decode(response.body)[0];
//print(jsonData['regions']);
  return UkraineData(
    name: jsonData['name'],
    regions: jsonData['regions'].map((region) {
      print(region['name']);
      return Region(
        name: region['name'],
        cities: region['cities'].map((city) {
          print(city);
          return City(name: city['name'], lat: city['lat'], lng: city['lng']);
        }).toList(),
      );
    }).toList(),
  );
}

class UrkMainScreen extends StatefulWidget {
  const UrkMainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<UrkMainScreen> {
  late Future<UkraineData> dataFuture;
  int selectedRegion = 0;
  int selectedCity = 0;

  List<dynamic> regions = [];
  List<dynamic> cities = [];

  @override
  void initState() {
    super.initState();
    dataFuture = loadData();
    print('init stated');
    selectedRegion = 0;
    selectedCity = 0;
  }

  @override
  Widget build(BuildContext context) {
    print(regions);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Ukrainian City Selection')),
        body: FutureBuilder<UkraineData>(
          future: dataFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              regions =
                  snapshot.data!.regions.map((region) => region.name).toList();
              cities.clear();

              var selectedRegionData = snapshot.data!.regions[selectedRegion];
              selectedRegionData.cities.forEach((city) {
                cities.add(city.name);
              });

              List<DropdownMenuItem<String>> cityItems = cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList();
              print('sel:');
              print(selectedCity);
              return Column(
                children: [
                  _buildRegionSelector(snapshot.data!, regions),
                  SizedBox(height: 16),
                  _buildCitySelector(selectedCity, cities),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      print('Selected Region: ${regions[selectedRegion]}');
                      print('Selected City: ${cities[selectedCity]}');
                      print(
                          'Selected City: ${selectedRegionData.cities[selectedCity].lat}');
                    },
                    child: Text('Select'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildRegionSelector(UkraineData data, List<dynamic> currentRegions) {
    List<DropdownMenuItem<int>> regionItems = currentRegions.map((region) {
      return DropdownMenuItem<int>(
        value: currentRegions.indexOf(region),
        child: Text(region),
      );
    }).toList();

    return Column(
      children: [
        DropdownButton<int>(
          items: regionItems,
          value: selectedRegion,
          onChanged: (int? newValue) {
            setState(() {
              selectedRegion = newValue ?? 0;
              print(selectedRegion);
              cities.clear();
              //  selectedRegion = data.regions.indexOf(newValue!) ?? 0;
              var selectedRegionData = data.regions[selectedRegion];

              selectedRegionData.cities.forEach((city) {
                print(city.name);
                cities.add(city.name);
              });
            });
          },
        ),
      ],
    );
  }

  Widget _buildCitySelector(int _selectedCity, List<dynamic> currentCities) {
    List<DropdownMenuItem<int>> cityItems = currentCities.map((city) {
      return DropdownMenuItem<int>(
        value: currentCities.indexOf(city),
        child: Text(city),
      );
    }).toList();
//return Text('a');
    return DropdownButton<int>(
        items: cityItems,
        onChanged: (int? newValue) {
          setState(() {
            selectedCity = newValue ?? 0;
          });
        },
        value: selectedCity);
  }
}
