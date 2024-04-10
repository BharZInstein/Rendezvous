import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  final String title;
  final String ground;
  final String time;
  final String date;
  final String numPlayers;
  final String equipment;

  InformationPage({
    required this.title,
    required this.ground,
    required this.time,
    required this.date,
    required this.numPlayers,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Ground', ground),
            _buildInfoRow('Time', time),
            _buildInfoRow('Date', date),
            _buildInfoRow('No. of Players', numPlayers),
            _buildInfoRow('Equipment', equipment),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}