void main() {
  
  List<int> array = [2, 4, 6, 8, 10, 12];

  print(" < traverse array with boring for loop > ");

  for (int i = 0; i < array.length; i++) {
    print(array[i]);
  }

  print(" < traverse array with foreach > ");
  array.forEach((e) { 
    print( " ${e*2}" ); 
  });

  print(" < traverse array while loop > ");
  int i = 0;
  while ( array[i] < 10 ) {
    print(array[i++]);
  }

}