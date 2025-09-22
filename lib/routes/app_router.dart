import 'package:go_router/go_router.dart';
import 'package:team_week_task/views/home_screen.dart';
import 'package:team_week_task/views/login_screen.dart';
import 'package:team_week_task/views/register_screen.dart';
import 'package:team_week_task/views/splash_screen.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(path: "/home", builder: (context, state) =>  HomeScreen()),
     GoRoute(path: "/splash", builder: (context, state) =>  SplashScreen()),
  ],
);
