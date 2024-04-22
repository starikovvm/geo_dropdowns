import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_object.freezed.dart';
part 'geo_object.g.dart';

@freezed
class GeoObject with _$GeoObject {
  const factory GeoObject({
    required int id,
    required String value,
  }) = _GeoObject;

  factory GeoObject.fromJson(Map<String, Object?> json) =>
      _$GeoObjectFromJson(json);
}
