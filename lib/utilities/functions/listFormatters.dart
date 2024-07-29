List<T> removeDuplicates<T>(List<T> list) {
  Set<T> uniqueSet = Set<T>.from(list);
  return uniqueSet.toList();
}
