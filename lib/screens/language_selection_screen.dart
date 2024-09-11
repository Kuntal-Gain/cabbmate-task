import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cabmate_task/widgets/language_tile.dart'; // Ensure you have this import

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  List<Color> colors = [
    Colors.green.shade800,
    Colors.red.shade400,
    Colors.blue.shade900,
    const Color(0xff75711b),
    Colors.green.shade900,
  ];

  List<String> langs = [
    'English',
    'Spanish (Español)',
    'French (Français)',
    'German (Deutsch)',
    'Italian (Italiano)',
    'Portuguese (Português)',
    'Russian (Русский)',
    'Chinese (中文)',
    'Japanese (日本語)',
    'Korean (한국어)',
    'Arabic (العربية)',
    'Hindi (हिन्दी)',
    'Turkish (Türkçe)',
    'Dutch (Nederlands)',
    'Swedish (Svenska)',
  ];

  String selectedLang = '';

  @override
  void initState() {
    super.initState();
    selectedLang = langs[0]; // Initialize with the first language
  }

  void chooseLang(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return Align(
                alignment: Alignment.center,
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xfff6f6f6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Select Language',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text("Which Language do you prefer?"),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffc2c2c2),
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.network(
                                      'https://cdn-icons-png.flaticon.com/512/9312/9312232.png',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xffc2c2c2)),
                            ),
                            margin: const EdgeInsets.all(15),
                            child: ListView.builder(
                              itemCount: langs.length,
                              itemBuilder: (ctx, idx) {
                                int randomIdx = Random().nextInt(colors.length);

                                return langTile(
                                  langs[idx],
                                  colors[randomIdx],
                                  selectedLang == langs[idx],
                                  (val) {
                                    setState(() {
                                      selectedLang = langs[idx];
                                    });
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => chooseLang(context),
          child: Text('Choose Lang - $selectedLang'),
        ),
      ),
    );
  }
}
