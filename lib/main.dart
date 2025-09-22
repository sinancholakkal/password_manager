import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/firebase_options.dart';
import 'package:password_manager/routes/app_router.dart';
import 'package:password_manager/state/auth_bloc/auth_bloc.dart';
import 'package:password_manager/state/firestore_bloc/firestore_bloc_dart_bloc.dart';
import 'package:password_manager/state/local_auth_bloc/local_auth_bloc.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => LocalAuthBloc(),
        ),
         BlocProvider(
          create: (context) => FirestoreBlocDartBloc(),
        ),
        
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: ThemeData(
         primaryColor: Color(0xFF1E6F9F),
        ),
        
      )
    );
  }
}

