

import 'package:busca_cep/pages/fragment/cidades_fragment.dart';
import 'package:busca_cep/pages/fragment/consulta_cep_fragment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  var _fragmentIndex = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_fragmentIndex == 0 ? ConsultaCepFragment.title :
        ConsultaCidadesFragment.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _fragmentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: ConsultaCepFragment.title
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: ConsultaCidadesFragment.title
            ),
          ],
        onTap: (int newIndex){
          if(newIndex != _fragmentIndex){
            setState(() {
              _fragmentIndex = newIndex;
            });
          }
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() => _fragmentIndex == 0 ? ConsultaCepFragment() :
      ConsultaCidadesFragment();

  Widget? _buildFloatingActionButton() {
    if (_fragmentIndex == 0){
      return null;
    }
    return FloatingActionButton(
      child: Icon(Icons.add),
        tooltip: 'Cadastrar',
        onPressed: () {}
    );

  }
}