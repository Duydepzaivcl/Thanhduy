class Weather {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String description;
  final String weatherCondition;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.weatherCondition,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      description: json['weather'][0]['description'],
      weatherCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
    );
  }
}
