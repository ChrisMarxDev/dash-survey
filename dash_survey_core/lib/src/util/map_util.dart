import 'dart:collection';

/// Extension to add convenience functions to maps
extension DashSurveyMapExtension<K, V> on Map<K, V> {
  /// Convert the map to a LinkedHashMap
  LinkedHashMap<K, V> toLinkedHashMap() {
    return LinkedHashMap.from(this);
  }
}
