import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:n_card/api/local_auth_api.dart';
import 'package:n_card/pages/home_page.dart';

class AuthenticatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Biometric'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // buildAvailability(context),
                const SizedBox(height: 24),
                buildAuthenticate(context),
              ],
            ),
          ),
        ),
      );

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();

          final  hasFingerprint = biometrics.contains(BiometricType.fingerprint);
          final  hasFaceId = biometrics.contains(BiometricType.face);

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildText('Biometrics', isAvailable),
                  buildText('Fingerprint', hasFingerprint),
                  buildText('FaceId', hasFaceId),
                ],
              ),
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? const Icon(Icons.check, color: Colors.green, size: 24)
                : const Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.lock_open,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();

          if (isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      );

  Widget buildButton({
    @required String? text,
    @required IconData? icon,
    @required VoidCallback? onClicked,
  }) =>
      MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        color: Colors.lightBlue,
        height: 50,
        minWidth: 250,
        onPressed: onClicked,
        child: const Text(
          'Authenticate',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
}
