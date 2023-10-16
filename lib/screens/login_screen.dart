import 'package:flutter/material.dart';
import 'package:hemayaweb/screens/join_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Implement your login logic here
    String email = emailController.text;
    String password = passwordController.text;

    // Example: Check if the credentials are valid
    if (email == 'hemaya@gmail.com' && password == 'hemaya123456') {
      // Perform login actions here
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const JoinScreen(
            selfCallerId: "1234",
            isCardVisible: false,
          ),
        ),
      );
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF009F98),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
          child: Card(
            color: Colors.white, // Set the background color here
            elevation: 3, // Add elevation for a subtle shadow
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Use min to make the card only as big as its children
                children: [
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/hemaya-860b8.appspot.com/o/hemaya.png?alt=media&token=1b098d8d-4c1a-4c4c-9710-40966c5ec534', // Replace with your actual image file path
                    height: 100, // Adjust the height as needed
                  ),
                  const SizedBox(height: 20),
                  // const Text(
                  //   "Login",
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009F98)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(
                                0xFF009F98)), // Set the color when not in focus
                      ),
                      labelStyle: TextStyle(color: Color(0xFF009F98)),
                      hintStyle: TextStyle(color: Color(0xFF009F98)),
                    ),
                    cursorColor: const Color(0xFF009F98),
                    style: const TextStyle(color: Color(0xFF009F98)),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF009F98)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(
                                0xFF009F98)), // Set the color when not in focus
                      ),
                      labelStyle: TextStyle(color: Color(0xFF009F98)),
                      hintStyle: TextStyle(color: Color(0xFF009F98)),
                    ),
                    cursorColor: const Color(0xFF009F98),
                    style: const TextStyle(color: Color(0xFF009F98)),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF009F98), // Background color
                      foregroundColor: Colors.white, // Text color
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
