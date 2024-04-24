import 'package:camera/camera.dart';
import 'package:camera_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Box? capturedImageBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final cameras = await availableCameras();
  capturedImageBox = await Hive.openBox('capturedImageBox');

  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription>? cameras;
  const MyApp({super.key, this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        cameras: cameras!,
      ),
    );
  }
}
