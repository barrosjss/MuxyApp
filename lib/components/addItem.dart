// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, unused_element, file_names

import 'package:flutter/material.dart';
import '../models/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final _startdateController = TextEditingController();
final _enddateController = TextEditingController();
final _roomController = TextEditingController();

class NewRecordDialog extends StatefulWidget {
  const NewRecordDialog({super.key});

  @override
  _NewRecordDialogState createState() => _NewRecordDialogState();
}

class _NewRecordDialogState extends State<NewRecordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _startdateController = TextEditingController();
  final _enddateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('New Record'),
      content: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _customerController,
              decoration: InputDecoration(labelText: 'Customer'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a customer';
                }
                return null;
              },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _startdateController,
                    decoration: InputDecoration(labelText: 'Start Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a start date';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        DateTime combined = DateTime(picked.year, picked.month,
                            picked.day, pickedTime.hour, pickedTime.minute);
                        _startdateController.text =
                            DateFormat("yyyy-MM-dd' 'HH:mm:ss")
                                .format(combined);
                      }
                    }
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _enddateController,
                    decoration: InputDecoration(labelText: 'End Date'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an end date';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        DateTime combined = DateTime(picked.year, picked.month,
                            picked.day, pickedTime.hour, pickedTime.minute);
                        _enddateController.text =
                            DateFormat("yyyy-MM-dd' 'HH:mm:ss")
                                .format(combined);
                      }
                    }
                  },
                ),
              ],
            ),
            TextFormField(
              controller: _roomController,
              decoration: InputDecoration(labelText: 'Room'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a room';
                }
                return null;
              },
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              _addRecord(_customerController.text, _startdateController.text,
                  _enddateController.text, _roomController.text);
            }
          },
        ),
      ],
    );
  }
}

void _addRecord(
    String customer, String startdate, String enddate, String room) async {
  final newRecord = Record(
    customer: customer,
    startdate: startdate,
    enddate: enddate,
    room: room, // nuevo campo
    reference: FirebaseFirestore.instance.collection('scheduling').doc(),
  );

  await newRecord.reference.set(newRecord.toMap());
}
