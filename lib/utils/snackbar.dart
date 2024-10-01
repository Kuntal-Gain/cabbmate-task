// for success

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

void successBar(BuildContext context, String text) {
  return DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
    animationDuration: const Duration(seconds: 1),
    builder: (context) => ToastCard(
      color: Colors.green,
      leading: const Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 28,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
  ).show(context);
}

// for failure

void failureBar(BuildContext context, String text) {
  return DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
    animationDuration: const Duration(seconds: 1),
    builder: (context) => ToastCard(
      color: Colors.red,
      leading: const Icon(
        Icons.cancel,
        color: Colors.white,
        size: 28,
      ),
      title: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),
      ),
    ),
  ).show(context);
}

// for update

void updateBar(BuildContext context, String text) {
  return DelightToastBar(
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
    animationDuration: const Duration(seconds: 1),
    builder: (context) => ToastCard(
      color: Colors.yellow,
      leading: const Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 28,
      ),
      title: Text(
        "$text...",
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
  ).show(context);
}
