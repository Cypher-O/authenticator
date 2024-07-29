String capitalize(String input) {
  return input.isNotEmpty
      ? input[0].toUpperCase() + input.substring(1).toLowerCase()
      : '';
}