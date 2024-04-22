import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geo_dropdowns/generated/locale_keys.g.dart';

abstract class DataException implements Exception {
  DataException();

  factory DataException.from(dynamic e) {
    if (e is DioException) {
      return NetworkDataException(e);
    } else {
      return ParsingDataException(e.toString());
    }
  }

  String get message;

  String get localizedDescription;
}

class NetworkDataException extends DataException {
  DioException dioException;

  NetworkDataException(this.dioException);

  @override
  String get message => dioException.message ?? LocaleKeys.errorUnknown.tr();

  @override
  String get localizedDescription => LocaleKeys.errorNetwork.tr();
}

class ParsingDataException extends DataException {
  ParsingDataException(this.message);

  @override
  final String message;

  @override
  String get localizedDescription => LocaleKeys.errorParsing.tr();
}
