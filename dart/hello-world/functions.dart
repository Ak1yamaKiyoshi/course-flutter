void main() {
  print(foo());
  print(square(2));
  print(() => print("A"));
}

String foo() {
  return " some cool string ";
}

int square(int a) {
  return a*a;
}