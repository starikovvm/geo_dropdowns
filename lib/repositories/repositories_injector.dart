import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_dropdowns/constants.dart' as constants;
import 'package:geo_dropdowns/repositories/geo_objects_repository.dart';

class RepositoriesInjector extends StatelessWidget {
  const RepositoriesInjector({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Dio(
        BaseOptions(
          baseUrl: constants.baseURL,
          headers: {
            'Content-Type': 'application/json',
            'X-API-Key': constants.apiKey,
            'User-Agent': constants.userAgent,
          },
        ),
      ),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => GeoObjectsRepository(
              dio: context.read(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
