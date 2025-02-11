import 'dart:collection';

extension MapExtension<K, V> on Map<K, V> {
  LinkedHashMap<K, V> toLinkedHashMap() {
    return LinkedHashMap.from(this);
  }
}
