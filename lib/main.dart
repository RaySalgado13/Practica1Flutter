import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_flutter/home.dart';
import 'firebase_options.dart';
import 'authentication.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'package:practica_flutter/comanda.dart';
import 'cart.dart';
import 'thanks.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: ((context, child) => const MyApp())
  ));
}

final _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => Consumer<ApplicationState>(
            builder: (context, appState, _) => DashboardScreen(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
          routes: [
            GoRoute(
              path: 'sign-in',
              builder: (context,state) =>
                  Authentication(),
            ),
            GoRoute(
                path: 'cart',
                builder: (context, state) {
                  Map<String, List<String>> params = state.extra as Map<String, List<String>>;
                  return Cart(orden: params['orden']!);
                }),
            GoRoute(
              path: 'orden-confirmada',
              builder: (context, state) => Despedida(),
            ),
          ]
      )
    ]
);



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
      routerConfig: _router
    );
  }
}

/*
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body:  Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm()
          ),
        ),
      ),
    );
  }
}


class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nombresTextController = TextEditingController();
  final _apellidosTextController = TextEditingController();
  double _progressCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateProgressBar,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(value: _progressCounter),
            Text('Sign Up :)', style: Theme.of(context).textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.fromLTRB(20,56,20,10),
              child: TextFormField(
                controller: _nombresTextController,
                decoration: const InputDecoration(hintText: 'Nombre(s)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 56),
              child: TextFormField(
                controller: _apellidosTextController,
                decoration: const InputDecoration(hintText: 'Apellidos'),
              ),
            ),
            TextButton(
              onPressed: _showDashboardScreen,
              style:
                ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states){
                      return states.contains(MaterialState.disabled) ? null : Colors.white;
                    }
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states){
                      return states.contains(MaterialState.disabled) ? null : Colors.blue;
                    }
                  ),
                ),
              child: const Text("Sign up"),
            )
          ],
        ),

    );
  }

  void _showDashboardScreen(){
    Navigator.of(context).pushNamed("dashboard");
  }

  void _updateProgressBar(){
    var progress = 0.0;
    final listControllers = [_nombresTextController, _apellidosTextController];
    for(final item in listControllers){
      if(item.value.text.isNotEmpty){
        progress += 1 / listControllers.length;
      }
    }
    setState(() {
      _progressCounter = progress;
    });
  }
}
*/


