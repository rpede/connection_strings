import 'package:flutter/material.dart';

final lightTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlue,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

final darkTheme = ThemeData.from(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);

const modes = [
  (ThemeMode.system, Icons.invert_colors),
  (ThemeMode.dark, Icons.dark_mode),
  (ThemeMode.light, Icons.light_mode),
];

class ThemeChanger extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const ThemeChanger({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: themeNotifier.value,
      items: [
        for (final (mode, icon) in modes)
          DropdownMenuItem(
            value: mode,
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(mode.name),
              ],
            ),
          ),
      ],
      onChanged: (value) {
        themeNotifier.value = value as ThemeMode;
      },
    );
  }
}
