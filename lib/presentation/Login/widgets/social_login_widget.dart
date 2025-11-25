import 'package:flutter/material.dart';

class SocialLoginWidget extends StatelessWidget {
  final bool isRegistration;

  const SocialLoginWidget({
    Key? key,
    this.isRegistration = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey[400])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey[400])),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                icon: Icons.g_mobiledata,
                label: 'Google',
                onPressed: () {
                  // Handle Google login/registration
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _SocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                onPressed: () {
                  // Handle Facebook login/registration
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }
}
