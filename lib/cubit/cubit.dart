import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/cubit/states.dart';
import 'package:weather_app/helpers/dio_helper.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);
  double? lat;
  double? lon;

  WeatherModel? weatherModel;
  Future<void> getWeather() async {
    emit(WeatherLoading());
    LocationPermission permission = await Geolocator.requestPermission();
    debugPrint(permission.toString());
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    lat = position.latitude;
    lon = position.longitude;
    try {
      final response = await DioHelper.getData(
        url: 'data/2.5/weather',
        query: {
          'lat': lat,
          'lon': lon,
          'appid': '74e9e9eb7a0cb36f705afc1ce8a7cf79',
          'units': 'metric',
        },
      );
      weatherModel = WeatherModel.fromJson(response!.data);
      emit(WeatherSuccess());
    } catch (error) {
      //print(error.toString());
      emit(WeatherError());
    }
  }
}
