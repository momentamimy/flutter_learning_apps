import 'package:first_test/math_utils.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){
  test("addition two numbers", (){
    //arrange
    int a = 10;
    int b = 5;
    //act
    int sum = MathUtils.add(a, b);
    //assert
    expect(sum, 15);
  });
}