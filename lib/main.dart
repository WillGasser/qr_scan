import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

// App State Management
class MyAppState extends ChangeNotifier {
  String qrData =
      'https://www.youtube.com/embed/LWNk7oJRbi0?start=33&autoplay=1';

  // Method to update QR code data
  void updateQR(String newData) {
    qrData = newData;
    notifyListeners(); // Notify UI to rebuild
  }
}

// Root Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), // Provide app state
      child: MaterialApp(
        title: 'QR Scanner',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          scaffoldBackgroundColor:
              const Color(0xFFF8F8F8), // Off-white background
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

// Home Page
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'QR Scanner Example',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // QR Code Display
            QrImageView(
              data: appState.qrData,
              version: QrVersions.auto,
              size: 500.0,
            ),
            const SizedBox(height: 20), // Spacer

            // Elevated Button to Update QR Code
            ElevatedButton(
              onPressed: () {
                // Update the QR code with new data
                appState.updateQR(
                    'https://www.youtube.com/watch?v=9I-2rAxBd-4&t=834s&ab_channel=B9poy');
              },
              child: const Text('Generate New QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
