import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isElevated;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isElevated = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = isElevated
        ? ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(text),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Text(text),
          );

    return button;
  }
}