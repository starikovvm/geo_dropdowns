import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geo_dropdowns/models/geo_object.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required HomeSectionState countriesState,
    required HomeSectionState? statesState,
    GeoObject? selectedCountry,
    GeoObject? selectedState,
    HomeAction? action,
  }) = _HomeState;
}

@freezed
class HomeSectionState with _$HomeSectionState {
  const factory HomeSectionState.loaded({
    required List<GeoObject> objects,
  }) = _Loaded;

  const factory HomeSectionState.loading() = _Loading;

  const factory HomeSectionState.error(String description) = _Error;
}

@freezed
class HomeAction with _$HomeAction {
  const factory HomeAction.openSubmitAlert() = _OpenSubmitAlert;
}
