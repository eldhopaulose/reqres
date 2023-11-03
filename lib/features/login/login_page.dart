import 'package:flutter/material.dart';
import 'package:reqres/features/home/home_page.dart';
import 'package:reqres/networks/dio/repo/auth_repo.dart';
import 'package:reqres/networks/models/user_model.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async{
                  final AuthRepo repo = AuthRepo();
                  final response = await repo.loginRequest(
                    UserModel(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );

                  if (response != null && response?.error == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response!.error.toString(),),)
                    );
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
