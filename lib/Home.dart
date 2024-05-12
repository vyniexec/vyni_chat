// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:whatsapp/screens/contatos.dart';
import 'package:whatsapp/screens/conversas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState(){
    super.initState();

    _tabController = TabController(
      length: 2, 
      vsync: this
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade900,
        title: const Text('VyniChat', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          indicatorWeight: 4,
          unselectedLabelColor: Colors.white,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Conversas'),
            Tab(text: 'Contatos')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Conversas(),
          Contatos(),
        ] 
      )
    );
  }
}
