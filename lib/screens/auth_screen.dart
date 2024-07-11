import 'package:flutter/material.dart';
import 'package:uas_novia/screens/todo_list.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/image/todo.png"),
              height: 200,
            ),
          
            
            const SizedBox(height: 16),
            TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor:Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 66, 58, 183),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 66, 58, 183),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

            // TASK: Tambahkan 1 TextField untuk usename.

            const SizedBox(height: 16),
            TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor:Color.fromARGB(255, 255, 255, 255),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 66, 58, 183),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 66, 58, 183),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

            const SizedBox(height: 16),
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // TASK: tambahkan validasi untuk cek username juga.

                  if (emailController.text == 'nopi@mail.com' &&
                      passwordController.text == 'password') {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>TodoListpage()),
                        (route) => false);
                  }

                  // TASK: tambahkan kondisi untuk cek jika email atau password kosong maka tampilkan showSnacBar() seperti contoh di bawah

                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email atau password salah'),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}