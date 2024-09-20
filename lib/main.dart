import 'package:connection_strings/converter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connection Strings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Connection Strings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Convert connection strings to .NET format',
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
