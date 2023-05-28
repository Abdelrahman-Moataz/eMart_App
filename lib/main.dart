import 'package:emart/consts/consts.dart';
import 'package:emart/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          ///to set icon bar color
          iconTheme: IconThemeData(
            color: darkFontGrey
          ),
            backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}