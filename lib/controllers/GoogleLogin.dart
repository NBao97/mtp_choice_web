import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mtp_choice_web/constants.dart' as constant;

Future<String> login(String title) async {
  final response = await http.post(
    Uri.parse('https://api.wimln.ml/api/Authenticate'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'ggToken': title,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return 'Success';
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return 'Failed.' + response.statusCode.toString();
  }
}

Future<String> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final user1 = await FirebaseAuth.instance.signInWithCredential(credential);
  constant.userName = user1.user!.displayName.toString();
  constant.key = user1.user!.getIdToken().toString();
  if (constant.userName == '') {
    constant.userName = user1.user!.email.toString();
  }
  // Once signed in, return the UserCredential
  return user1.user!.getIdToken();
}
