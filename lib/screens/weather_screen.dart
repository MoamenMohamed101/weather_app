import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/cubit.dart';
import 'package:weather_app/cubit/states.dart';

class WeatherViewState extends StatelessWidget {
  const WeatherViewState({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WeatherCubit()..getWeather(),
      child: BlocConsumer<WeatherCubit, WeatherState>(
        builder: (BuildContext context, state) {
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var cubit = WeatherCubit.get(context);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'City Code: ${cubit.weatherModel!.sys!.country}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Monday, September 6, 2023',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Icon(
                  Icons.cloud,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Text(
                  '${cubit.weatherModel!.main!.temp}°C',
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(height: 10),
                Text(
                  cubit.weatherModel!.weather![0].main!,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    WeatherInfoItem(
                        title: 'Wind',
                        value: '${cubit.weatherModel!.wind!.speed} m/s'),
                    WeatherInfoItem(
                      title: 'Humidity',
                      value: cubit.weatherModel!.main!.humidity.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  '5-Day Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      ForecastItem(
                        day: 'Mon',
                        temperature: '24°C',
                        icon: Icons.cloud,
                      ),
                      ForecastItem(
                        day: 'Tue',
                        temperature: '24°C',
                        icon: Icons.cloud,
                      ),
                      ForecastItem(
                        day: 'Wed',
                        temperature: '24°C',
                        icon: Icons.cloud,
                      ),
                      ForecastItem(
                        day: 'Thu',
                        temperature: '24°C',
                        icon: Icons.cloud,
                      ),
                      ForecastItem(
                        day: 'Fri',
                        temperature: '24°C',
                        icon: Icons.cloud,
                      ),
                    ],
                  )
                ),
              ],
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}

class WeatherInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const WeatherInfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ForecastItem extends StatelessWidget {
  final String day;
  final String temperature;
  final IconData icon;

  const ForecastItem(
      {super.key,
      required this.day,
      required this.temperature,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            day,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Icon(
            icon,
            size: 40,
            color: Colors.blue,
          ),
          const SizedBox(height: 10),
          Text(
            temperature,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
//ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return const ForecastItem(
//                         day: 'Mon',
//                         temperature: '24°C',
//                         icon: Icons.cloud,
//                       );
//                     },
//                   ),
