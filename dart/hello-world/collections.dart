import 'dart:io';

void main () {
  // lists

  List<String> strlist = ["I", " ", "don't", " ", "now"];
  List dynamicList = [1, 2, 4, "ok", true];
  List <int> cont_int_list = const [4, 2, 6];

  strlist.forEach((element) {stdout.write(element);});
  print("");
  dynamicList.forEach((element) {stdout.write(element);});
  print("");
  cont_int_list.forEach((element) {stdout.write(element);});
  print("");
  var concat_lists = [...strlist, ...dynamicList, ...cont_int_list];
  concat_lists.forEach((element) {stdout.write(element);});
  print("");
  // sets 
  var unique = {1, 5, 2, 1, 2, 2, 2, 2, 2};
  print(unique); // {1, 5, 2}
  var empty_set = new Set();
  print(empty_set);
  empty_set.add(1);
  print(empty_set);
  Set another_way_to_declare_empty_set = {};
  print(another_way_to_declare_empty_set);
  // maps 
  Map like_in_javascript = {
    1: "idk",
    2: "idddl"
  };
  print(like_in_javascript[1]);

}