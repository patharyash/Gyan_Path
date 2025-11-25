import 'package:flutter/material.dart';

import 'widgets/login_form_widget.dart';
import 'widgets/login_header_widget.dart';
import 'widgets/social_login_widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeaderWidget(),
                    const SizedBox(height: 48),
                    const LoginFormWidget(),
                    const SizedBox(height: 24),
                    const SocialLoginWidget(),
                    const SizedBox(height: 24),
                    _buildSignUpPrompt(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/registration');
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
