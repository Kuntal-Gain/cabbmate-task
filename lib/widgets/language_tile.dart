import 'package:flutter/material.dart';

Widget langTile(String lang, Color color, bool isSelected,
    ValueChanged<String?> onChanged) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Center(
                child: Text(
                  lang.substring(0, 2),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                lang,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Radio<String>(
            //   value: lang,
            //   groupValue: isSelected ? lang : null,
            //   onChanged: (value) {
            //     onChanged(value);
            //   },
            // ),
            GestureDetector(
              onTap: () => onChanged(lang),
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: !isSelected
                      ? Border.all(
                          color: const Color(0xffc2c2c2),
                        )
                      : Border.all(color: Colors.transparent),
                  shape: BoxShape.circle,
                ),
                child: isSelected
                    ? Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: isSelected
                              ? Border.all(
                                  color: const Color(0xffc2c2c2),
                                )
                              : Border.all(color: Colors.transparent),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
      const Divider(height: 1),
    ],
  );
}
