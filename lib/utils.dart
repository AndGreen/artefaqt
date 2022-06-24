import 'package:artefaqt/model.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension EnumToString on Enum {
  String getTitle() => (this).toString().split('.').last.toCapitalized();
}

extension ToogleItem on SortModes {
  SortModes toogle() =>
      SortModes.values[((this).index + 1) % SortModes.values.length];
}
