import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? errorUsername;
  String? errorPassword;

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            textFieldUsername(usernameController, errorUsername),
            textFieldPassword(passwordController, errorPassword),
            buttonLogin(),
          ],
        ),
      ),
    );
  }

  Widget textFieldUsername(
    TextEditingController controller,
    String? error,
  ) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Username",
        border: const OutlineInputBorder(),
        errorText: error,
      ),
      controller: controller,
      onChanged: onChangeUsername,
    );
  }

  Widget textFieldPassword(
    TextEditingController controller,
    String? error,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Password",
          border: const OutlineInputBorder(),
          errorText: error,
        ),
        controller: controller,
        obscureText: true,
        onChanged: onChangePassword,
      ),
    );
  }

  Widget buttonLogin() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: login,
            child: const Text("Login"),
          )),
    );
  }

  void login() {
    String username = usernameController.text;
    String password = passwordController.text;
    if (username.isEmpty) {
      setState(() {
        errorUsername = "Username is required";
      });
    }
    if (password.isEmpty) {
      setState(() {
        errorPassword = "Password is required";
      });
    }
    if (username.isNotEmpty && password.isNotEmpty) {
      Navigator.pop(context, username);
    }
  }

  void onChangePassword(String value) {
    if (value.isNotEmpty) {
      setState(() {
        errorPassword = null;
      });
    }
  }

  void onChangeUsername(String value) {
    if (value.isNotEmpty) {
      setState(() {
        errorUsername = null;
      });
    }
  }
}
