import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title; // Use event_name instead of title
  final String date;
  final String startTime;
  final String endTime;
  final String area;
  final String equipment;
  final int players; // Assuming players is an integer
  final String contactInfo;
  final String creatorName;
  final String creatorEmail;

  const Event({
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.area,
    required this.equipment,
    required this.players,
    required this.contactInfo,
    required this.creatorName,
    required this.creatorEmail,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Event(
      title: data['event_name'] as String,
      date: data['date'] as String,
      startTime: data['start_time'] as String,
      endTime: data['end_time'] as String,
      area: data['area'] as String,
      equipment: data['equipment'] as String,
      players: data['players'] as int,
      contactInfo: data['contactInfo'] as String,
      creatorName: data['creator_name'] as String,
      creatorEmail: data['creator_email'] as String,
    );
  }
}
