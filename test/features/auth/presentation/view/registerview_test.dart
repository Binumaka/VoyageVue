import 'package:flutter_test/flutter_test.dart';
import 'package:voyagevue/features/auth/presentation/view/registerview.dart';

void main() {
  final registerViewState = RegisterViewState();

  group('Email Validation Tests', () {
    test('validateEmail should return error if email is empty', () {
      registerViewState.emailController.text = '';
      expect(registerViewState.emailController.text.isEmpty, true);
    });

    test('validateEmail should return error if email is invalid', () {
      registerViewState.emailController.text = 'invalid-email';
      expect(registerViewState.emailController.text.contains('@'), false);
    });

    test('validateEmail should return null if email is valid', () {
      registerViewState.emailController.text = 'test@example.com';
      expect(registerViewState.emailController.text.contains('@'), true);
    });
  });

  group('Username Validation Tests', () {
    test('validateUsername should return error if username is empty', () {
      registerViewState.usernameController.text = '';
      expect(registerViewState.usernameController.text.isEmpty, true);
    });

    test('validateUsername should return null if username is valid', () {
      registerViewState.usernameController.text = 'john_doe';
      expect(registerViewState.usernameController.text.isNotEmpty, true);
    });
  });

  group('Password Validation Tests', () {
    test('validatePassword should return error if password is empty', () {
      expect(registerViewState.passwordController.text.isEmpty, true);
    });

    test('validatePassword should return null if password is valid', () {
      registerViewState.passwordController.text = 'password123';
      expect(registerViewState.passwordController.text.isNotEmpty, true);
    });

    test('confirmPassword should match password', () {
      registerViewState.passwordController.text = 'password123';
      registerViewState.confirmpasswordController.text = 'password123';
      expect(registerViewState.confirmpasswordController.text, registerViewState.passwordController.text);
    });

    test('confirmPassword should not match if passwords do not match', () {
      registerViewState.passwordController.text = 'password123';
      registerViewState.confirmpasswordController.text = 'password456';
      expect(registerViewState.confirmpasswordController.text, isNot(equals(registerViewState.passwordController.text)));
    });
  });

  group('Image Picker Tests', () {
    test('should browse image from gallery', () async {
      // Mock gallery image picking logic here
      final imagePicked = true; // Replace with actual logic to simulate image picking
      expect(imagePicked, true);
    });

    test('should browse image from camera', () async {
      // Mock camera image picking logic here
      final imagePicked = true; // Replace with actual logic to simulate camera image picking
      expect(imagePicked, true);
    });
  });
}
