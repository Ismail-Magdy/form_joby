import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/form/presentation/screens/form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: "##############", anonKey: "##############");

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive UI based on a standard web design size
    return ScreenUtilInit(
      designSize: const Size(1440, 900), // Standard desktop size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Joby Form',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const FormScreen(),
        );
      },
    );
  }
}
