import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _getBackgroundColor(weather.weatherCondition),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                weather.cityName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 24),
              _getWeatherIcon(weather.weatherCondition),
              SizedBox(height: 16),
              Text(
                '${weather.temperature.round()}°C',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                weather.description,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildWeatherDetail(
                    'Độ ẩm',
                    '${weather.humidity}%',
                    Icons.water_drop_outlined,
                  ),
                  _buildWeatherDetail(
                    'Gió',
                    '${weather.windSpeed} km/h',
                    Icons.air,
                  ),
                  _buildWeatherDetail(
                    'Cảm giác',
                    '${weather.feelsLike.round()}°C',
                    Icons.thermostat,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 28),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _getWeatherIcon(String condition) {
    IconData iconData;
    double size = 80;

    switch (condition) {
      case 'Clear':
        iconData = Icons.wb_sunny;
        break;
      case 'Clouds':
        iconData = Icons.cloud;
        break;
      case 'Rain':
      case 'Drizzle':
        iconData = Icons.grain;
        break;
      case 'Thunderstorm':
        iconData = Icons.flash_on;
        break;
      case 'Snow':
        iconData = Icons.ac_unit;
        break;
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
        iconData = Icons.cloud_queue;
        break;
      default:
        iconData = Icons.cloud_queue;
    }

    return Icon(
      iconData,
      size: size,
      color: Colors.white,
    );
  }

  List<Color> _getBackgroundColor(String condition) {
    switch (condition) {
      case 'Clear':
        return [Colors.blue[400]!, Colors.blue[800]!];
      case 'Clouds':
        return [Colors.blueGrey[400]!, Colors.blueGrey[800]!];
      case 'Rain':
        return [Colors.blueGrey[700]!, Colors.indigo[900]!];
      case 'Drizzle':
        return [Colors.indigo[400]!, Colors.indigo[800]!];
      case 'Thunderstorm':
        return [Colors.deepPurple[400]!, Colors.deepPurple[900]!];
      case 'Snow':
        return [Colors.lightBlue[300]!, Colors.lightBlue[700]!];
      default:
        return [Colors.cyan[400]!, Colors.cyan[800]!];
    }
  }
}
