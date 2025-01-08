import 'package:flutter/material.dart';
import 'package:forum_app/controllers/authentication.dart';
import 'package:get/get.dart';
import '../register/register_page.dart';
import 'widgets/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login page",
                style: GoogleFonts.poppins(fontSize: size * 0.080),
              ),
              const SizedBox(
                height: 20,
              ),
              LoginInputWidget(
                hintext: 'Email',
                obscurText: false,
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              LoginInputWidget(
                hintext: 'Password',
                obscurText: true,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _authenticationController.login(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                  child: Obx (() {
                      return _authenticationController.isLoading.value?
                      const Center(child: CircularProgressIndicator(),)
                      : Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text('Register',
                      style: GoogleFonts.poppins(
                          fontSize: size * 0.040, color: Colors.blue)))
            ],
          ),
        ),
      ),
    );
  }
}
