import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 80),
                FadeTransition(
                  opacity: _fadeInAnimation,
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                FadeTransition(
                  opacity: _fadeInAnimation,
                  child: Text(
                    "Login to your account",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                _buildEmailTextField(),
                SizedBox(height: 20),
                _buildPasswordTextField(),
                SizedBox(height: 20),
                _buildLoginButton(),
                SizedBox(height: 15),
                _buildForgotPassword(),
                SizedBox(height: 20),
                _buildCreateAccountOption(),
                SizedBox(height: 20),
                _buildSocialLoginButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "Enter your email",
          prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: TextField(
        controller: passwordController,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: ElevatedButton(
        onPressed: () {
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 10,
        ),
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: GestureDetector(
        onTap: () {
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountOption() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: GestureDetector(
        onTap: () {
        },
        child: Text(
          "Create Account",
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _socialButton("assets/images/google_logo.png", () {
          }),
          SizedBox(width: 20),
          _socialButton("assets/images/facebook_logo.png", () {
          }),
        ],
      ),
    );
  }

  Widget _socialButton(String assetPath, void Function()? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: Image.asset(
          assetPath,
          height: 30,
        ),
      ),
    );
  }
}

