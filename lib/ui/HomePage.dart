import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _typeAheadController = TextEditingController();

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
          height: 150,
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
            padding: EdgeInsets.fromLTRB(0, 70, 0, 80),
            child: Row(
              children: <Widget>[_QuantitativoHomem(), _QuantitativoMulher()],
            )),
        Padding(
          padding: EdgeInsets.all(10),
          child: ButtonTheme(
            height: 40,
            child: RaisedButton(
              child: Text("Consultar", style: TextStyle(fontSize: 20)),
              onPressed: () {},
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
            Text("50",
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
            Text("50",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30.0))
          ],
        ),
      ),
    );
  }
}
