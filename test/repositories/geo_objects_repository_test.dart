import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_dropdowns/repositories/geo_objects_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'geo_objects_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();

  setUp(() {
    when(dio.get('countries')).thenAnswer((_) async => Response(
          data: [
            {'id': 1, 'value': 'Country 1'},
            {'id': 2, 'value': 'Country 2'},
          ],
          statusCode: 200,
          requestOptions: RequestOptions(path: 'countries'),
        ));
    when(dio.get('countries/1/states')).thenAnswer((_) async => Response(
          data: [
            {'id': 1, 'value': 'State 1'},
            {'id': 2, 'value': 'State 2'},
          ],
          statusCode: 200,
          requestOptions: RequestOptions(path: 'countries/1/states'),
        ));
  });

  test('getCountries', () async {
    final repository = GeoObjectsRepository(dio: dio);
    final countries = await repository.getCountries();
    expect(countries, hasLength(2));
    expect(countries[0].id, 1);
    expect(countries[0].value, 'Country 1');
    expect(countries[1].id, 2);
    expect(countries[1].value, 'Country 2');
  });

  test('getStates', () async {
    final repository = GeoObjectsRepository(dio: dio);
    final states = await repository.getStates(1);
    expect(states, hasLength(2));
    expect(states[0].id, 1);
    expect(states[0].value, 'State 1');
    expect(states[1].id, 2);
    expect(states[1].value, 'State 2');
  });
}
