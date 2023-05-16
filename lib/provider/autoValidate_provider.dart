
//auto validate provider
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoValidateMode = StateNotifierProvider<AutoValidate, AutovalidateMode>((ref) => AutoValidate(AutovalidateMode.onUserInteraction));

class AutoValidate extends StateNotifier<AutovalidateMode>{
  AutoValidate(super.state);

  void autoValidate(){
    state = AutovalidateMode.onUserInteraction;
  }
  // void autoValidateDisable(){
  //   state = AutovalidateMode.disabled;
  // }
}