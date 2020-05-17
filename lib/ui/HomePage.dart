import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _typeAheadController = TextEditingController();

  int _quantidadeDeHomens = 0;
  int _quantidadeDeMulheres = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text("Quantidade de alunos"),
//        ),
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 170,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/menu.png'), fit: BoxFit.fill)),
//          child: Text(_typeAheadController.text),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: _InputTextCurso(),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 70, 0, 140),
            child: Row(
              children: <Widget>[_QuantitativoHomem(), _QuantitativoMulher()],
            )),
        Padding(
          padding: EdgeInsets.all(10),
          child: ButtonTheme(
            height: 40,
            child: RaisedButton(
              child: Text("Consultar", style: TextStyle(fontSize: 20)),
              onPressed: () {
                _ConsultarQuantidadePessoas().then((resultado) {
                  setState(() {
                    double qtdHomem = resultado['Homens'][0];
                    _quantidadeDeHomens = qtdHomem.toInt();

                    double qtdMulheres = resultado['Mulheres'][0];
                    _quantidadeDeMulheres = qtdMulheres.toInt();
                  });
                });
              },
              color: Colors.green,
              textColor: Colors.black,
            ),
          ),
        )
      ],
    )));
  }

  Widget _InputTextCurso() {
    return SingleChildScrollView(
        child: TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._typeAheadController,
          decoration: InputDecoration(labelText: 'Curso')),
      suggestionsCallback: (pattern) {
        return BackendService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        setState(() {
          this._typeAheadController.text = suggestion;
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Por favor informe um curso';
        }
      },
//          onSaved: (value) => this._selectedCity = value,
    ));
  }

  Widget _QuantitativoHomem() {
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 5,
        color: Colors.lightBlue[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'images/capelo_homem.png',
              width: 50,
              height: 50,
              alignment: Alignment.center,
            ),
            Text("Quantidade",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            Text(_quantidadeDeHomens.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30.0))
          ],
        ),
      ),
    );
  }

  Widget _QuantitativoMulher() {
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 5,
        color: Colors.lightBlue[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'images/capelo_mulher.png',
              width: 50,
              height: 50,
              alignment: Alignment.center,
            ),
            Text("Quantidade",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            Text(_quantidadeDeMulheres.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30.0))
          ],
        ),
      ),
    );
  }

  Future<Map> _ConsultarQuantidadePessoas() async {
    http.Response response;

    String nomeDoCurso = _typeAheadController.text;
    if (nomeDoCurso != null) {
      String idCurso = BackendService.cursosComId()[nomeDoCurso];
      response =
          await http.get('http://192.168.1.6:8000/api/curso/?idCurso=$idCurso');
    }

    print(json.decode(response.body));
    return json.decode(response.body);
  }
}
