import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

main() {
  runApp(
    MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = ["List a", "List b"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.pinkAccent)),
                  ),
                ),
                RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(_toDoList[index]["title"]),
                      value: _toDoList[index]["ok"],
                      secondary: CircleAvatar(
                        child: Icon(
                            _toDoList[index]["ok"] ? Icons.check : Icons.error),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  //Função para obter o arquivo
  Future<File> _getFile() async {
    final directory =
        await getApplicationDocumentsDirectory(); // ele esta pegando o diretorio de onde esta sendo gravado as tarefas
    return File(
        "${directory.path}/data.json"); //ele vai retornar esse diretorio e adicinar no json
  }

  //Função para salvar o arquivo
  Future<File> _dataSave() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  //Função para ler o arquivo
  Future<String> _readData() async {
    try {
      final file = await _getFile();
    } catch (e) {
      return null;
    }
  }
}
