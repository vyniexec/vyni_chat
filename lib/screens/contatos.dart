import 'package:flutter/material.dart';
import 'package:whatsapp/model/contatos.dart';

class Contatos extends StatefulWidget {
  const Contatos({super.key});

  @override
  State<Contatos> createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {
  
  List<Contato> listaContatos = [
    Contato(
      'Vinicius',
      'https://firebasestorage.googleapis.com/v0/b/whatsapp-cd6ca.appspot.com/o/perfil%2Fperfil.png?alt=media&token=7db90f0f-9673-41ca-9dd3-2820aece8243'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: listaContatos.length,
            itemBuilder: (context, indice) {

              Contato contatos = listaContatos[indice];

              return ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(contatos.caminhoFoto),
                ),
                title: Text(
                  contatos.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                onTap: (() {})
              );
            }),
      );
  }
}