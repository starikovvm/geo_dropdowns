import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_dropdowns/features/home/home_cubit.dart';
import 'package:geo_dropdowns/features/home/home_state.dart';
import 'package:geo_dropdowns/features/home/widgets/home_dropdown.dart';
import 'package:geo_dropdowns/generated/locale_keys.g.dart';
import 'package:geo_dropdowns/models/geo_object.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        geoObjectsRepository: context.read(),
      ),
      child: const _HomeWidgetContent(),
    );
  }
}

class _HomeWidgetContent extends StatefulWidget {
  const _HomeWidgetContent();

  @override
  State<_HomeWidgetContent> createState() => _HomeWidgetContentState();
}

class _HomeWidgetContentState extends State<_HomeWidgetContent> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().onInitState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.action != current.action && current.action != null,
      listener: _onActionChanged,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocSelector<HomeCubit, HomeState,
                    (HomeSectionState state, GeoObject? selectedObject)>(
                  selector: (state) {
                    return (state.countriesState, state.selectedCountry);
                  },
                  builder: (context, countriesState) {
                    return HomeSection(
                      state: countriesState.$1,
                      selectedObject: countriesState.$2,
                      hint: LocaleKeys.homeSelectCountry.tr(),
                      onObjectSelected: (object) =>
                          context.read<HomeCubit>().onCountrySelected(object!),
                      onRetry: context.read<HomeCubit>().loadCountries,
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocSelector<HomeCubit, HomeState,
                    (HomeSectionState? state, GeoObject? selectedObject)>(
                  selector: (state) {
                    return (state.statesState, state.selectedState);
                  },
                  builder: (context, statesState) {
                    return HomeSection(
                      state: statesState.$1,
                      selectedObject: statesState.$2,
                      hint: LocaleKeys.homeSelectState.tr(),
                      onObjectSelected: (object) =>
                          context.read<HomeCubit>().onStateSelected(object),
                      onRetry: context.read<HomeCubit>().loadStates,
                    );
                  },
                ),
                const Spacer(),
                BlocSelector<HomeCubit, HomeState, bool>(
                  selector: (state) {
                    return state.selectedCountry != null &&
                        state.selectedState != null;
                  },
                  builder: (context, hasSelectedObjects) {
                    if (!hasSelectedObjects) {
                      return const SizedBox();
                    }
                    return ElevatedButton(
                      onPressed: context.read<HomeCubit>().onSubmitPressed,
                      child: Text(LocaleKeys.homeSubmit.tr()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onActionChanged(BuildContext context, HomeState state) {
    state.action?.when(
      openSubmitAlert: _openSubmitAlert,
    );
  }

  void _openSubmitAlert() {
    showAdaptiveDialog(
      context: context,
      builder: (_) {
        return AlertDialog.adaptive(
          title: Text(LocaleKeys.homeSubmitAlertTitle.tr()),
          content: Text(LocaleKeys.homeSubmitAlertText.tr(namedArgs: {
            'country': context.read<HomeCubit>().state.selectedCountry!.value,
            'state': context.read<HomeCubit>().state.selectedState!.value,
          })),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(LocaleKeys.ok.tr()),
            ),
          ],
        );
      },
    );
  }
}
