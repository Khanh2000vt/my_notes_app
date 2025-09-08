List<T> replaceOrAddItemsToArrayByKey<T, K>(
  List<T> roots,
  List<T> array,
  K Function(T item) keySelector,
) {
  final map = <K, T>{for (var item in roots) keySelector(item): item};

  for (var item in array) {
    map[keySelector(item)] = item;
  }

  return map.values.toList();
}
