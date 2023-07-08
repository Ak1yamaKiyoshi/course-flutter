
var string = "hello world";
var integer= 1;
var floatn = 3.14;
var doublen= 3.213123123;
var array = [1, 2, 3];
var boolean = true;
var object = {
  "name": "Huston",
  "message": "dart is so similar to c, c++, js, python"
};

int static_int = 0;
double static_double = 3.22;
String static_string = " yay ";
bool static_bool = true;
dynamic this_can_be_any_type = 1;

void main() {
  this_can_be_any_type = "a";
  print(this_can_be_any_type);
  this_can_be_any_type = 4.2;
  print(this_can_be_any_type);
  this_can_be_any_type = [1, 2, 4];
  print(this_can_be_any_type);
  print(" I have a\n string '$string', \n integer $integer \n float $floatn \n array of integers $array \n $object \n integer + floart ${ integer + floatn } \n bool $boolean \n double $doublen ");
} 