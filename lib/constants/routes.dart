import 'package:flutter/cupertino.dart';

const loginRoute = '/login/';
const registerRoute = '/register/';
const homeScreenRoute = '/homeScreen/';
const verifyEmailRoute = '/verifyEmail/';

namedRout(BuildContext context, String rout) {
  Navigator.pushNamedAndRemoveUntil(context, rout, (route) => false);
}
