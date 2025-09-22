


import 'package:go_router/go_router.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/views/add_item_screen.dart';
import 'package:password_manager/views/home_screen.dart';
import 'package:password_manager/views/login_screen.dart';
import 'package:password_manager/views/register_screen.dart';
import 'package:password_manager/views/screen_splash.dart';
import 'package:password_manager/views/view_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(path: "/home", builder: (context, state) =>  HomeScreen()),
     GoRoute(path: "/splash", builder: (context, state) =>  ScreenSplash()),
     GoRoute(path: '/viewItem', builder: (context, state) {
      final passWordModel = state.extra as PasswordModel;
      return ViewScreen(passwordModel: passWordModel,);
     }),
     GoRoute(path: '/addedit', builder: (context, state) {
      final Map<String,dynamic> params = state.extra as Map<String,dynamic>;

      return AddEditItemScreen(type: params['type'],passwordModel: params['model'],);
     }),
  ],
);
