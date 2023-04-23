extension RemoveAll on String {
  /// Remove all characters in [values] from a [String]
  ///
  /// Example:
  ///
  /// final s = '#FF00FF'.removeAll(['#', '0x]); // FF00FF
  /// final s2 = '0xFF3322'.removeAll(['#', '0x']); // FF3322
  String removeAll(Iterable<String> values) => values.fold(
        this,
        (result, value) => result.replaceAll(
          value,
          '',
        ),
      );
}
