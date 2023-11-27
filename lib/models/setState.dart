import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muxyapp/models/record.dart';

class ReservaMotel extends StatefulWidget {
  @override
  _ReservaMotelState createState() => _ReservaMotelState();
}

class _ReservaMotelState extends State<ReservaMotel> {
  List<Record> _reservas = [];

  @override
  void initState() {
    super.initState();
    // Aquí puedes cargar las reservas desde Firestore
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _reservas.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_reservas[index].customer),
          subtitle: Text(
              '${_reservas[index].startdate} - ${_reservas[index].enddate}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _reservas.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }
}
