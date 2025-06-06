import 'dart:convert';

import 'package:busca_cep/model/cep.dart';
import 'package:http/http.dart';

class CepService{

  static const base_url = 'https://viacep.com.br/ws/:cep/json/';

  Future<Map<String, dynamic>> findCep(String cep) async{
    final url = base_url.replaceAll(':cep', cep);
    final uri = Uri.parse(url);
    final response = await get(uri);

    if (response.statusCode != 200 || response.body.isEmpty){
      throw Exception();
    }
    final decodeBody = jsonDecode(response.body);
    return Map<String, dynamic>.from(decodeBody);
  }

  Future<Cep> findCepAsObject(String cep) async{
    final map = await findCep(cep);
    return Cep.fromJson(map);
  }

}