import 'package:connection_strings/converter.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Connection Strings',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: MyHomePage(
            title: 'Connection Strings',
            themeNotifier: themeNotifier,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const MyHomePage({
    super.key,
    required this.title,
    required this.themeNotifier,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final uriTextController = TextEditingController();
  final dotnetTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [ThemeChanger(themeNotifier: widget.themeNotifier)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Convert Postgres connection strings to .NET format.',
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    key: const ValueKey("uri-input"),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("URI format"),
                      hintText:
                          "postgres://user:pwd@hostname:5432/db?sslmode=require",
                    ),
                    controller: uriTextController,
                  ),
                  Text(
                    "Format used by DataGrip, Aiven, ElephantSQL etc.",
                    style: textTheme.bodySmall,
                  ),
                  const Divider(),
                  TextField(
                    key: const ValueKey("dotnet-input"),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(".NET format"),
                    ),
                    controller: dotnetTextController,
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: onConvert,
                    child: const Text("Convert"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onConvert() {
    final uri = uriTextController.text;
    if (uri.isEmpty) return;
    dotnetTextController.text = convertToDotNet(uri);
  }

  TextTheme get textTheme => Theme.of(context).textTheme;
}
