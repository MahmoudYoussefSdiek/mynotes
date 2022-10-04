import 'package:flutter/material.dart';

namedRout(BuildContext context, String rout) {
  Navigator.pushNamedAndRemoveUntil(context, rout, (route) => false);
}

pushNamedRout(BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}
