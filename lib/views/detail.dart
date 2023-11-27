// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../models/record.dart';

class DetailScreen extends StatelessWidget {
  final Record record;

  DetailScreen({super.key, required this.record});

  Future<void> deleteRecord(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Record'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this record?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await record.deleteRecord();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> editRecord(BuildContext context) async {
    final TextEditingController customerController =
        TextEditingController(text: record.customer);
    final TextEditingController startdateController =
        TextEditingController(text: record.startdate);
    final TextEditingController enddateController =
        TextEditingController(text: record.enddate);
    final TextEditingController roomController =
        TextEditingController(text: record.room);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Record'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: customerController,
                  decoration: InputDecoration(labelText: 'Customer'),
                ),
                TextField(
                  controller: startdateController,
                  decoration: InputDecoration(labelText: 'Start date'),
                ),
                TextField(
                  controller: enddateController,
                  decoration: InputDecoration(labelText: 'End date'),
                ),
                TextField(
                  controller: roomController,
                  decoration: InputDecoration(labelText: 'Room'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                await record.updateRecord(
                  customerController.text,
                  startdateController.text,
                  enddateController.text,
                  roomController.text,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => editRecord(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => deleteRecord(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Customer'),
                subtitle: Text(record.customer),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Start date'),
                subtitle: Text(record.startdate),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('End date'),
                subtitle: Text(
                  record.enddate,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.room),
                title: Text('Room'),
                subtitle: Text(record.room),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
