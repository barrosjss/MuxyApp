import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String customer;
  final String startdate;
  final String enddate;
  final String room;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['customer'] != null),
        assert(map['startdate'] != null),
        assert(map['enddate'] != null),
        customer = map['customer'],
        startdate = (map['startdate'] as Timestamp).toDate().toString(),
        enddate = (map['enddate'] as Timestamp).toDate().toString(),
        room = map['room'] ?? '';

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  Record(
      {required this.customer,
      required this.startdate,
      required this.enddate,
      required this.room,
      required this.reference});

  Map<String, dynamic> toMap() {
    return {
      'customer': customer,
      'startdate': Timestamp.fromDate(DateTime.parse(startdate)),
      'enddate': Timestamp.fromDate(DateTime.parse(enddate)),
      'room': room,
    };
  }

  Future<void> updateRecord(
      String customer, String startdate, String enddate, String room) async {
    await reference.update({
      'customer': customer,
      'startdate': Timestamp.fromDate(DateTime.parse(startdate)),
      'enddate': Timestamp.fromDate(DateTime.parse(enddate)),
      'room': room,
    });
  }

  Future<void> deleteRecord() async {
    await reference.delete();
  }

  @override
  String toString() => "Record<$customer:$startdate:$enddate>";
}
