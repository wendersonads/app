import 'package:auth_migration/core/auth/token_service.dart';
import 'package:auth_migration/domain/model/token_model.dart';
import 'package:auth_migration/domain/service/auth_service.dart';
import 'package:auth_migration/view/login/login_screen.dart';
import 'package:auth_migration/view/peca/peca_list.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/NavBarWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  NavbarWidget(),
      body: Container(
        margin: const EdgeInsets.only(left: 50, right: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const PecaList(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('LISTA DE PEÇAS'),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
