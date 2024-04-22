import 'package:dio/dio.dart';
import 'package:geo_dropdowns/models/geo_object.dart';
import 'package:geo_dropdowns/models/data_exception.dart';

class GeoObjectsRepository {
  GeoObjectsRepository({required Dio dio}) : _dio = dio;

  final Dio _dio;

  /// Returns a list of countries.
  /// Throws a [DataException] if an error occurs.
  Future<List<GeoObject>> getCountries() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await _dio.get('countries');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((e) => GeoObject.fromJson(e as Map<String, Object?>))
          .toList();
    } catch (e) {
      throw DataException.from(e);
    }
  }

  /// Returns a list of states for the given country [countryId].
  /// Throws a [DataException] if an error occurs.
  Future<List<GeoObject>> getStates(int countryId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final response = await _dio.get('countries/$countryId/states');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((e) => GeoObject.fromJson(e as Map<String, Object?>))
          .toList();
    } catch (e) {
      throw DataException.from(e);
    }
  }
}
