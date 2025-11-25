import 'package:flutter/material.dart';
import 'package:studyplanner/presentation/Registration/widgets/registration_form_widget.dart';
import 'package:studyplanner/presentation/login/login_screen.dart';

import '../Login/widgets/social_login_widget.dart';
import 'widgets/registration_header_widget.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const RegistrationHeaderWidget(),
                  const SizedBox(height: 32),
                  const RegistrationFormWidget(),
                  const SizedBox(height: 24),
                  const SocialLoginWidget(isRegistration: true),
                  const SizedBox(height: 24),
                  _buildLoginPrompt(context),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          },
          child: const Text(
            'Login',
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
