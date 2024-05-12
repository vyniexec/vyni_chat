// ignore_for_file: unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/login.dart';
import 'package:whatsapp/model/user.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController _controlName = TextEditingController(); // Controlador para recuparar o que foi digitado no campo nome
  final TextEditingController _controlNumber = TextEditingController(); // Controlador para recuparar o que foi digitado no campo nome
  final TextEditingController _controlEmail = TextEditingController(); // Controlador para recuparar o que foi digitado no campo email
  final TextEditingController _controlPassword = TextEditingController(); // Controlador para recuparar o que foi digitado no campo senha
  String msgError = '';
  bool credencial = true; // Criando e inicializando a variável em true

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

  void cadastro(Usuario usuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Verificar se o email já está em uso
    QuerySnapshot querySnapshot = await firestore
        .collection('usuarios')
        .where('email', isEqualTo: usuario.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Se houver documentos na consulta, significa que o email já está em uso
      setState(() {
        msgError = 'Este email já está em uso';
      });
      return; // Retorna sem tentar criar o usuário
    }
    auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.password,
    )
    .then((firebaseUser) {
      setState(() {
        msgError = 'Usúario criado com sucesso!';
      });

      FirebaseFirestore.instance
          .collection("usuarios")
          .doc(usuario.name)
          .set(usuario.toMap());

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      });
    }).catchError((error) {
      setState(() {
        msgError = 'Erro ao criar o usúario!';
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
                Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    icon: const Icon(Icons.keyboard_backspace),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 32),
                //   child: Image.asset('images/logo_whatsapp.png',
                //       width: 300, height: 250),
                // ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _controlName,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          label: Text('NOME'),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    )),
                    Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _controlNumber,
                      autofocus: false,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                      decoration: const InputDecoration(
                          label: Text('Número'),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _controlEmail,
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          label: Text('E-MAIL'),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _controlPassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                          label: Text('PASSWORD'),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              cadastro(Usuario(_controlName.text, _controlNumber.text,
                                  _controlEmail.text, _controlPassword.text));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 31, 31, 31)),
                            child: const Text(
                              'Cadastrar',
                              style: TextStyle(color: Colors.white),
                            )))),
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
