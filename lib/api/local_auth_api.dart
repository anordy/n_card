import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print("================   error on getbiometrics  ===============");
      print(e);
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
          localizedReason: 'Scan Fingerprint to Authenticate',
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Biometric authentication!',
              cancelButton: 'No thanks',
            ),
          ]);
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
