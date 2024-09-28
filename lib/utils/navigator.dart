import 'package:flutter/material.dart';

void toNavigate(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
}
