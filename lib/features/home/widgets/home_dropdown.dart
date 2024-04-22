import 'package:flutter/material.dart';
import 'package:geo_dropdowns/features/home/home_state.dart';
import 'package:geo_dropdowns/models/geo_object.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
    required this.state,
    required this.selectedObject,
    required this.hint,
    required this.onObjectSelected,
    required this.onRetry,
  });

  final HomeSectionState? state;
  final GeoObject? selectedObject;
  final String hint;
  final void Function(GeoObject?) onObjectSelected;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    if (state == null) {
      return const SizedBox();
    }
    return state!.when(
      loaded: (objects) => DropdownButton(
        items: objects
            .map((object) => DropdownMenuItem(
                  value: object,
                  child: Text(object.value),
                ))
            .toList(),
        onChanged: onObjectSelected,
        value: selectedObject,
        hint: Text(hint),
        isExpanded: true,
      ),
      loading: () => const CircularProgressIndicator.adaptive(),
      error: (description) => Column(
        children: [
          Text(description),
          TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
