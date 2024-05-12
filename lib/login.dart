// ignore_for_file: unrelated_type_equality_checks

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Home.dart';
import 'package:whatsapp/cadastro.dart';
import 'package:whatsapp/model/user.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controlName = TextEditingController();
  final TextEditingController _controlNumber = TextEditingController();
  final TextEditingController _controlEmail =
      TextEditingController(); // Controlador de texto para recuparar o que foi digitado no campo email
  final TextEditingController _controlPassword =
      TextEditingController(); // Controlador de texto para recuparar o que foi digitado no campo senha
  bool credencial = true;
  String msgError = '';

  bool verificarCredenciais(email, senha) {
    bool emailValido = email.contains('@');
    bool senhaValida = senha.length >= 8;
    String errorMsg = '';

    if (!emailValido) {
      errorMsg += 'Insira um email válido. ';
    }

    if (!senhaValida) {
      errorMsg += 'Insira uma senha válida (com pelo menos 8 caracteres).';
    }

    setState(() {
      msgError = errorMsg;
    });

    return emailValido && senhaValida;
  }

  void login(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.password,
    ).then((firebaseUser) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
      _controlEmail.text = '';
      _controlPassword.text = '';
    }).catchError((error) {
      setState(() {
        msgError = 'Email ou senha incorreta!';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Image.asset('images/logo_whatsapp.png',
                      width: 300, height: 250),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _controlEmail,
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-MAIL',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _controlPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'PASSWORD',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          credencial = verificarCredenciais(
                              _controlEmail.text, _controlPassword.text);
                        });
                        if (credencial) {
                          login(Usuario(_controlName.text, _controlNumber.text, _controlEmail.text,
                              _controlPassword.text));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 31, 31, 31)),
                      child: const Text('Entrar',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Cadastro()));
                      },
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 31, 31, 31))),
                      child: const Text('Não tem conta? Cadastre-se',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(msgError,
                      style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
