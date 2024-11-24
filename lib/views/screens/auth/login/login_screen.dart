import 'package:flutter/material.dart';
import 'package:mcq/views/components/custom_button.dart';
import 'package:mcq/views/components/custom_text_field.dart';
import 'package:mcq/views/components/custom_text_field_for_password.dart';
import 'package:mcq/utils/validator.dart';
import 'package:mcq/views/screens/auth/login/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  final LoginViewModel vm;

  const LoginScreen({
    super.key,
    required this.vm,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: widget.vm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              /// EMAIL OR MOBILE NUMBER
              const SizedBox(height: 5),
              CustomTextField(
                labelText: "User Name",
                hintText: "Enter Email or Mobile Number",
                errorText: widget.vm.userNameError.value,
                keyboardType: TextInputType.emailAddress,
                controller: widget.vm.userNameController.value,
                suffixIcon: Icons.person,
                validator: Validator.validateUserName,
              ),

              /// PASSWORD
              const SizedBox(height: 20),
              CustomTextFieldForPassword(
                labelText: "Password",
                controller: widget.vm.passwordController.value,
                validator: Validator.validatePassword,
              ),

              /// Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: widget.vm.onPressedForgetPass,
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              /// SUBMIT BUTTON
              const SizedBox(height: 10),
              CustomButton(
                title: "LOGIN",
                width: MediaQuery.of(context).size.width,
                onPressed: widget.vm.login,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
