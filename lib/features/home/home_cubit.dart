import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_dropdowns/features/home/home_state.dart';
import 'package:geo_dropdowns/generated/locale_keys.g.dart';
import 'package:geo_dropdowns/models/data_exception.dart';
import 'package:geo_dropdowns/models/geo_object.dart';
import 'package:geo_dropdowns/repositories/geo_objects_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required GeoObjectsRepository geoObjectsRepository})
      : _geoObjectsRepository = geoObjectsRepository,
        super(const HomeState(
          countriesState: HomeSectionState.loading(),
          statesState: null,
        ));

  final GeoObjectsRepository _geoObjectsRepository;

  void onInitState() {
    loadCountries();
  }

  Future<void> onCountrySelected(GeoObject? country) async {
    emit(state.copyWith(
      selectedCountry: country,
      selectedState: null,
    ));
    await loadStates();
  }

  void onStateSelected(GeoObject? state) {
    emit(this.state.copyWith(
          selectedState: state,
        ));
  }

  void onSubmitPressed() {
    if (state.selectedCountry == null || state.selectedState == null) {
      return;
    }
    _performAction(const HomeAction.openSubmitAlert());
  }

  Future<void> loadCountries() async {
    emit(state.copyWith(
      countriesState: const HomeSectionState.loading(),
    ));

    try {
      final countries = await _geoObjectsRepository.getCountries();
      if (isClosed) return;
      emit(state.copyWith(
        countriesState: HomeSectionState.loaded(objects: countries),
      ));
    } on DataException catch (e) {
      if (kDebugMode) print(e.message);
      if (isClosed) return;
      emit(state.copyWith(
        countriesState: HomeSectionState.error(e.localizedDescription),
      ));
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(
        countriesState: HomeSectionState.error(LocaleKeys.errorUnknown.tr()),
      ));
    }
  }

  Future<void> loadStates() async {
    final countryId = state.selectedCountry?.id;
    if (countryId == null) {
      return;
    }

    emit(state.copyWith(
      statesState: const HomeSectionState.loading(),
    ));

    try {
      final states = await _geoObjectsRepository.getStates(countryId);
      if (isClosed) return;
      emit(state.copyWith(
        statesState: HomeSectionState.loaded(objects: states),
      ));
    } on DataException catch (e) {
      if (kDebugMode) print(e.message);
      if (isClosed) return;
      emit(state.copyWith(
        statesState: HomeSectionState.error(e.message),
      ));
    } catch (_) {
      if (isClosed) return;
      emit(state.copyWith(
        statesState: HomeSectionState.error(LocaleKeys.errorUnknown.tr()),
      ));
    }
  }

  void _performAction(HomeAction action) {
    emit(state.copyWith(action: action));
    emit(state.copyWith(action: null));
  }
}
