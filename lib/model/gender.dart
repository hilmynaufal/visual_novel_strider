import 'package:hive/hive.dart';

enum Gender { M, F }

final genderValues = EnumValues({"f": Gender.F, "m": Gender.M});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T>? map;
  Map<T, String>? reverseMap;

  Map<T, String>? get reverse {
    reverseMap;
    return reverseMap;
  }
}
