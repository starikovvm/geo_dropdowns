# geo_dropdowns

A simple app with two dropdowns.

It uses BLoC as a state management solution.

## Architecture

The app uses the BLoC pattern to manage the state of the app.

The structure of the app is as follows:

- `features/` - contains feature-specific code and BLoC classes (if needed). Each feature has its own folder.
- `generated/` - contains generated code (e.g. localization classes). The generated code is not stored in the repository.
- `models/` - contains the models used in the app.
- `repositories/` - contains the repositories used to fetch data.
- `ui/` - contains helper classes for the UI (e.g. themes, colors).

## Dependency injection

Dependency injection is done using the BLoC library's `RepositoryProvider`. The providers are defined in the `repositories/repositories_injector.dart` file.

## Flutter Version

This project uses [FVM](https://fvm.app/) to manage the Flutter version. The version is stored in the `.fvm` file. To install the Flutter version, run the following command:

```bash
fvm install
```

To run the correct Flutter executable, run the following command:

```bash
fvm flutter [command]
```

## Code generation

### Freezed and JSON models

This app uses code generation via freezed and json_annotation packages for the BLoC state classes an JSON models. To generate the classes, run the following command:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or you can use the watch command to automatically generate the classes when a file changes:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

When using VSCode, you can use the Build Runner extension to run the watch command automatically when saving a file.

### Localization

Also code generation is used for the localization. To generate the localization classes, run the following command:

```bash
fvm flutter pub run easy_localization:generate -S assets/translations -f json -O lib/generated -o codegen_loader.g.dart;
fvm flutter pub run easy_localization:generate -S assets/translations -f keys -O lib/generated -o locale_keys.g.dart
```

When using VSCode, you can use Run on Save extension to run the command automatically when saving a file. The configuration for the extension is added to the `.vscode/settings.json` file.

## Tests

The app has unit tests for the BLoC classes and the repositories. The tests for UI classes are not implemented due to lack of time 🤷‍♂️. To run the tests, run the following command:

```bash
fvm flutter test
```
