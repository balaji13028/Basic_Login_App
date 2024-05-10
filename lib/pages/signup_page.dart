import 'package:devpoint_solutions/provider/firestore_provider.dart';
import 'package:devpoint_solutions/widgets/custom_buttons.dart';
import 'package:devpoint_solutions/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final List<String> genderOptions = ['Male', 'Female'];
  String? gender;

  void createAccount() {
    context.read<FireStoreProvider>().createAccount(
          email: _emailController.text.trim(),
          password: _emailController.text.trim(),
          gender: gender,
          name: _nameController.text.trim(),
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        text: 'Name',
                        prefix: const Icon(Icons.person),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '*This field is mandatory';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
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
                      const SizedBox(height: 15),
                      TextFieldWidget(
                        text: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        textCapitalization: TextCapitalization.none,
                        obscureText: hidePassword,
                        controller: _passwordController,
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
                      const SizedBox(height: 15),
                      DropdownButtonFormField(
                        value: gender,
                        // padding: const EdgeInsets.all(20),
                        onChanged: (String? value) {
                          setState(() {
                            gender = value;
                          });
                        },
                        items: genderOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return '*This field is mandatory';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                              gender == 'Male' ? Icons.male : Icons.female),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          errorStyle:
                              const TextStyle(fontSize: 10, height: 0.1),
                          labelText: 'Gender',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),
                      CustomButtons().primaryButton(
                        size: size,
                        text: 'Sign up',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            createAccount();
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
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
              ]),
        ),
      ),
    );
  }
}
