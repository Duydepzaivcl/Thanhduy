import 'package:flutter/material.dart';
import 'package:weather_app_web_opensource/widgets/index.dart';
import 'package:weather_app_web_opensource/models/weather_model.dart';

class WeatherHomeUI extends StatelessWidget {
  final TextEditingController cityController;
  final VoidCallback onSearch;
  final VoidCallback onGetCurrentLocation;
  final bool isLoading;
  final String errorMessage;
  final Weather? weatherData;

  const WeatherHomeUI({
    super.key,
    required this.cityController,
    required this.onSearch,
    required this.onGetCurrentLocation,
    required this.isLoading,
    required this.errorMessage,
    required this.weatherData,
  });

  Color _getBackgroundColor() {
    if (weatherData == null) return Colors.blueGrey;
    switch (weatherData!.cityName.toLowerCase()) {
      case 'clear':
        return Colors.blue;
      case 'clouds':
        return Colors.grey;
      case 'rain':
        return Colors.indigo;
      case 'snow':
        return Colors.white;
      case 'thunderstorm':
        return Colors.deepPurple;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_getBackgroundColor(), Colors.black87],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: 'Nhập tên thành phố',
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: const Color.fromARGB(157, 33, 149, 243), width: 2),
                ),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black38,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                shadowColor: Colors.black54,
              ),
              child: Text(
                'Tìm',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onGetCurrentLocation,
              icon: Icon(Icons.my_location, color: Colors.white),
              label: Text('Vị trí hiện tại',
                  style: TextStyle(color: Colors.white)),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
              ),
            ),
            SizedBox(height: 16),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (errorMessage.isNotEmpty)
              Center(
                  child:
                      Text(errorMessage, style: TextStyle(color: Colors.red)))
            else if (weatherData != null)
              Expanded(
                child: WeatherDisplay(weather: weatherData!),
              ),
          ],
        ),
      ),
    );
  }
}
