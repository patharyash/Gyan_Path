import 'package:flutter/material.dart';

class ForgotPasswordHeaderWidget extends StatelessWidget {
  const ForgotPasswordHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_reset,
              size: 50,
              color: Colors.blue,
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Don\'t worry! Enter your email address and we\'ll send you a link to reset your password.',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
