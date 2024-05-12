import 'package:flutter/material.dart';
import 'package:whatsapp/model/conversa.dart';

class Conversas extends StatefulWidget {
  const Conversas({super.key});

  @override
  State<Conversas> createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {

  List<Conversa> listaConversas = [
    Conversa(
      'Vinicius',
      'Olá mundo',
      'https://firebasestorage.googleapis.com/v0/b/whatsapp-cd6ca.appspot.com/o/perfil%2Fperfil.png?alt=media&token=7db90f0f-9673-41ca-9dd3-2820aece8243'
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: listaConversas.length,
            itemBuilder: (context, indice) {

              Conversa conversa = listaConversas[indice];

              return ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(conversa.caminhoFoto),
                ),
                title: Text(
                  conversa.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                subtitle: Text(
                  conversa.mensagem,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
                onTap: (() {})
              );
            }),
      );
  }
}