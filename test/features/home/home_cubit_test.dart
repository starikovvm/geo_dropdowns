import 'package:flutter_test/flutter_test.dart';
import 'package:geo_dropdowns/features/home/home_cubit.dart';
import 'package:geo_dropdowns/models/geo_object.dart';
import 'package:geo_dropdowns/repositories/geo_objects_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([GeoObjectsRepository])
void main() {
  final geoObjectsRepository = MockGeoObjectsRepository();

  setUp(() {
    when(geoObjectsRepository.getCountries()).thenAnswer((_) async => [
          const GeoObject(id: 1, value: 'Country 1'),
          const GeoObject(id: 2, value: 'Country 2'),
        ]);
    when(geoObjectsRepository.getStates(1)).thenAnswer((_) async => [
          const GeoObject(id: 1, value: 'State 1'),
          const GeoObject(id: 2, value: 'State 2'),
        ]);
  });

  test('loadCountries', () async {
    final cubit = HomeCubit(geoObjectsRepository: geoObjectsRepository);
    await cubit.loadCountries();
    final countriesState = cubit.state.countriesState;
    countriesState.maybeWhen(
      loaded: (objects) {
        expect(objects, hasLength(2));
        expect(objects[0].id, 1);
        expect(objects[0].value, 'Country 1');
        expect(objects[1].id, 2);
        expect(objects[1].value, 'Country 2');
      },
      orElse: () => fail('Expected loaded state'),
    );
  });

  test('onCountrySelected', () async {
    final cubit = HomeCubit(geoObjectsRepository: geoObjectsRepository);
    await cubit.loadCountries();
    await cubit.onCountrySelected(const GeoObject(id: 1, value: 'Country 1'));
    final state = cubit.state;
    expect(state.selectedCountry?.id, 1);
    expect(state.selectedCountry?.value, 'Country 1');
    expect(state.selectedState, isNull);

    final statesState = state.statesState;
    expect(statesState, isNotNull);
    statesState?.maybeWhen(
      loaded: (objects) {
        expect(objects, hasLength(2));
        expect(objects[0].id, 1);
        expect(objects[0].value, 'State 1');
        expect(objects[1].id, 2);
        expect(objects[1].value, 'State 2');
      },
      orElse: () => fail('Expected loaded state'),
    );
  });
}
