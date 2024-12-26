import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

// Root Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _MyAppState(), // Provide app state
      child: MaterialApp(
        title: 'QR Scanner',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          scaffoldBackgroundColor:
              const Color(0xFFF8F8F8), // Off-white background
        ),
        home: const LoadingScreen(), // Start with Loading Screen
      ),
    );
  }
}

class _MyAppState extends ChangeNotifier {
  String qrData =
      'https://www.youtube.com/embed/LWNk7oJRbi0?start=33&autoplay=1';

  // Method to update QR code data
  void updateQR(String newData) {
    qrData = newData;
    notifyListeners(); // Notify UI to rebuild
  }
}

//Loading Screen
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3), // 2 seconds animation
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);

    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward().then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Cleanup controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation, // Connect animation to FadeTransition
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// Home Page
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<_MyAppState>();

    // Get the screen width dynamically
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.all(screenWidth * 0.1), // 10% of screen width as padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dynamic Title
            Text(
              'QR Scanner Example',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: screenWidth * 0.07, // 7% of screen width
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Spacer

            // Dynamic QR Code Display
            QrImageView(
              data: appState.qrData,
              version: QrVersions.auto,
              size: screenWidth * 0.6, // 60% of screen width
            ),
            const SizedBox(height: 20), // Spacer

            // Dynamic Button
            SizedBox(
              width: screenWidth * 0.5, // 50% of screen width
              height: screenWidth * 0.1, // 10% of screen width
              child: ElevatedButton(
                onPressed: () {
                  // Update the QR code with new data
                  appState.updateQR(
                    'https://www.youtube.com/watch?v=9I-2rAxBd-4&t=834s&ab_channel=B9poy',
                  );
                },
                child: Text(
                  'Generate New QR Code',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04, // 4% of screen width
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigation Bar
class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR_Code'), // Title
        actions: [
          IconButton(
            icon: Image.asset('assets/icon1.png'), // Image button 1
            onPressed: () {
            },
          ),
          IconButton(
            icon: Image.asset('assets/icon2.png'), // Image button 2
            onPressed: () {
              Link
            },
          ),
        ],
      ),
    );
  }
}
