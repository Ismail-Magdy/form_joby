import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/form/presentation/screens/form_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase.
  // IMPORTANT: Replace with actual URL and Anon Key when running.
  // We use placeholder values here to ensure the app compiles.
  await Supabase.initialize(
    url: "https://auoloqdhytirfnvazyft.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF1b2xvcWRoeXRpcmZudmF6eWZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM3NzcwMTIsImV4cCI6MjA4OTM1MzAxMn0.5EqbLv8XeRm65LA8KKpo5SwYGZ3nd5X49ZsX2rRHCc8",
  );

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
