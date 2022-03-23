import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailFormField(),
            passwordFormField(),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
            ),
            submitButton()
          ],
        ),
      ),
    );
  }

  Widget emailFormField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "email",
          hintText: "pass your email",
          icon: Icon(Icons.email)),
      keyboardType: TextInputType.emailAddress,
      validator: (String? value) {
        return validateEmail(value);
      },
    );
  }

  /*
  * return string when error
  * */
  String? validateEmail(String? email) {
    String? result;
    String errorMessage = "email is wrong";

    if (email == null || email.isEmpty) {
      result = "email is null";
      return result;
    } else {
      bool resultValidate = validateEmailFormat(email);
      print("validateEmailFormat(email) $resultValidate");
      if (resultValidate) {
        return result;
      } else {
        result = errorMessage;
        return result;
      }
    }
  }

  Widget passwordFormField() {
    return TextFormField(
      obscureText: true,
      validator: (String? value) {
        return passwordValidate(value);
      },
      decoration: const InputDecoration(
          labelText: "password",
          hintText: "pass your password",
          icon: Icon(Icons.lock)),
    );
  }

  SizedBox submitButton() {
    return SizedBox(
      width: 100,
      child: FittedBox(
        child: ElevatedButton(
          onPressed: () {
            print('formKey ${formKey.currentState}');

            bool? validated = formKey.currentState?.validate();
            print('validated: $validated');
            if(validated != null && validated) {
              formKey.currentState?.save();
            }
          },
          child: const Text(
            'เข้าสู่ระบบ',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }

  /*
  * return true when correct
  * */
  bool validateEmailFormat(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  String? passwordValidate(String? password) {

    String? result;
    String errorMessage = "password is wrong";

    if (password == null || password.isEmpty) {
      result = "password is null";
      return result;
    } else {
      bool resultValidate = password.length < 8;
      print("validateEmailFormat(email) $resultValidate");
      if (resultValidate) {
        return result;
      } else {
        result = errorMessage;
        return result;
      }
    }
  }
}
