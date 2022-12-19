import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> formKey = GlobalKey();

  String email = '';
  String password = '';
}
