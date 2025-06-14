

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../model/cep.dart';
import '../../services/cep_service.dart';

class ConsultaCepFragment extends StatefulWidget{
  static const title = 'Consulta CEP';

  @override
  State<StatefulWidget> createState() => _ConsultaCepFragment();
}

class _ConsultaCepFragment extends State<ConsultaCepFragment>{

  final _cepService = CepService();
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _loading = false;
  final _cepFormat = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#' : RegExp(r'[0-9]')}
  );

  Cep? _cep;

  @override
  Widget build(BuildContext context){
    return Padding(
        padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'CEP',
                  suffixIcon: _loading ? const Padding(
                      padding: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ) : IconButton(
                      onPressed: _findCep,
                      icon: Icon(Icons.search)
                  ),
                ),
                inputFormatters: [_cepFormat],
                validator: (String? value){
                  if (value == null || value.isEmpty ||
                      !_cepFormat.isFill()){
                    return 'Informe um CEP válido';
                  }
                  return null;
                },
              ),
          ),
          Container(height: 10),
          ..._buidResult(),
        ],
      ),
    );
  }

  Future<void> _findCep() async {
    if(_formKey.currentState == null ||
        !_formKey.currentState!.validate()){
      return;
    }
    setState(() {
      _loading = true;
    });
    try{
      _cep = await _cepService.findCepAsObject(_cepFormat.getUnmaskedText());
    }catch(e){
      debugPrint(e.toString());
    }
    setState(() {
      _loading = false;
    });
  }

  List<Widget> _buidResult(){
    final List<Widget> widgts = [];
    if(_cep != null){
      final map = _cep!.toJson();
      for(final key in map.keys){
        widgts.add(Text('$key - ${map[key]}'));
      }
    }
    return widgts;
  }

}