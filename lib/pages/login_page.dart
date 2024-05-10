import 'package:devpoint_solutions/pages/signup_page.dart';
import 'package:devpoint_solutions/provider/firestore_provider.dart';
import 'package:devpoint_solutions/widgets/custom_buttons.dart';
import 'package:devpoint_solutions/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signInMethod() {
    context.read<FireStoreProvider>().signIn(
        _emailController.text.trim(), _emailController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(height: 6),
              Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
              ),
              SizedBox(height: size.height * 0.05),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      text: 'Email',
                      prefix: const Icon(Icons.mail_outline),
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '*This field is mandatory';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Enter valid email ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      text: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePassword,
                      controller: _passwordController,
                      textCapitalization: TextCapitalization.none,
                      suffix: IconButton(
                        icon: hidePassword
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.black45,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.black,
                              ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                      prefix: const Icon(Icons.key_sharp),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '*This field is mandatory';
                        }
                        // else if (!RegExp(r'^(?=.*?[A-Z]).{1,}$')
                        //     .hasMatch(value)) {
                        //   return '* At least one uppercase.\n';
                        // } else if (!RegExp(r'^(?=.*?[!_@#$&*~]).{1,}$')
                        //     .hasMatch(value)) {
                        //   return '* At least one special character';
                        // } else if (value.length < 8) {
                        //   return 'Password must be at least 8 characters';
                        // }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.06),
                    CustomButtons().primaryButton(
                      size: size,
                      text: 'Login',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          signInMethod();
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      _emailController.clear();
                      _passwordController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignUpPage()));
                    },
                    child: const Text(
                      'Signup Now!',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
