import 'package:flutter/material.dart';
import 'package:forum_app/controllers/authentication.dart';
import 'package:forum_app/views/login/login_page.dart';
import 'package:get/get.dart';
import 'widgets/register_input.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    final isLoading = false.obs;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register page",
                style: GoogleFonts.poppins(fontSize: size * 0.080),
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterInputWidget(
                hintext: 'Name',
                obscurText: false,
                controller: _nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterInputWidget(
                hintext: 'userName',
                obscurText: false,
                controller: _userNameController,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterInputWidget(
                hintext: 'Email',
                obscurText: false,
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterInputWidget(
                hintext: 'Password',
                obscurText: true,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _authenticationController.register(
                        name: _nameController.text.trim(),
                        userName: _userNameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                  child: Obx(
                    () {
                      return _authenticationController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            );
                    },
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Login',
                      style: GoogleFonts.poppins(
                          fontSize: size * 0.040, color: Colors.blue)))
            ],
          ),
        ),
      ),
    );
  }
}
