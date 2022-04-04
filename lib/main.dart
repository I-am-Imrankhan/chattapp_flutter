import 'package:chattapp_flutter/providers/authenticationProvider.dart';
import 'package:chattapp_flutter/providers/counterViewModel.dart';
import 'package:chattapp_flutter/providers/user/userCredientials.dart';
import 'package:chattapp_flutter/screens/homePage.dart';
import 'package:chattapp_flutter/screens/login.dart';
import 'package:chattapp_flutter/screens/navigation/navigationbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CounterViewModel(),
        ),
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
          child: const NavigationDrawerWidget(),
        ),
        Provider<UserCredientials>(
          create: (_) => UserCredientials(FirebaseFirestore.instance , FirebaseAuth.instance),
          child: const NavigationDrawerWidget(),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationProvider>().authState,
            initialData: null)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const String title = 'Navigation Drawer';

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => const Authenticate()},
      /* title: 'CApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(), */
    );
  }
}

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    context.read<UserCredientials>().getUSerData();
    context.read<AuthenticationProvider>().printUserState();
    //Instance to know the authentication state.
    /* final firebaseUser = context.watch<User>();
    if (kDebugMode) {
      print('asdfasdfasdf adfasdf *************** $firebaseUser');
    } */
    //return MyHomePage();
    final currentUser = context.watch<AuthenticationProvider>().currentUser;
    if (kDebugMode) {
      //print("*******************************************, $currentUser");
    }
    return /* context.watch<AuthenticationProvider>().currentUser */FirebaseAuth.instance.currentUser != null ? MyHomePage()
            : const LoginScreen();
    /* context.watch<AuthenticationProvider>().isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : currentUser != null
            ? MyHomePage()
            : LoginScreen(); */

    /*if (firebaseUser != null) {
      //Means that the user is logged in already and hence navigate to HomePage
      return MyHomePage();
    }
    //The user isn't logged in and hence navigate to SignInPage.
    return LoginScreen();*/
  }
}
