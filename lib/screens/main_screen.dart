import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import '../widgets/index.dart';
import 'package:weather_app_web_opensource/services/index.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  final PreferencesService _preferencesService = PreferencesService();

  bool isLoading = false;
  String errorMessage = '';
  Weather? weatherData;

  @override
  void initState() {
    super.initState();
    _loadLastCity();
  }

  Future<void> _loadLastCity() async {
    final lastCity = await _preferencesService.getLastCity();

    if (lastCity != null && lastCity.isNotEmpty) {
      _cityController.text = lastCity;
      await _getWeatherByCity(lastCity);
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions denied');
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await _getWeatherByCoordinates(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        errorMessage = 'Không thể lấy vị trí: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _getWeatherByCoordinates(double lat, double lon) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final weather = await _weatherService.getWeatherByCoordinates(lat, lon);
      setState(() {
        weatherData = weather;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _getWeatherByCity(String city) async {
    if (city.isEmpty) {
      setState(() {
        errorMessage = 'Vui lòng nhập tên thành phố';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final weather = await _weatherService.getWeatherByCity(city);
      await _preferencesService.saveLastCity(city);
      setState(() {
        weatherData = weather;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WeatherHomeUI(
          cityController: _cityController,
          onSearch: () => _getWeatherByCity(_cityController.text),
          onGetCurrentLocation: _getCurrentLocation,
          isLoading: isLoading,
          errorMessage: errorMessage,
          weatherData: weatherData,
        ),
      ),
    );
  }
}
