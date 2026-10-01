void main() {
  print(someValue(25));
  print(someValue(null));
}

int someValue(int? value) {
  if (value == null) {
    return 0;
  }

  return value;
}
