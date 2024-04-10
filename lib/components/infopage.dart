import 'package:flutter/material.dart';

import '../event.dart';

class InformationPage extends StatelessWidget {
  final Event event;

  InformationPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title), // Use event.title for the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Title', event.title),
            _buildInfoRow('Date', event.date),
            _buildInfoRow('Start Time', event.startTime),
            _buildInfoRow('End Time', event.endTime),
            _buildInfoRow('Area', event.area),
            _buildInfoRow('Equipment', event.equipment),
            _buildInfoRow('Players', event.players.toString()), // Convert players to string
            _buildInfoRow('Contact Info', event.contactInfo),
            _buildInfoRow('Creator Name', event.creatorName),
            _buildInfoRow('Creator Email', event.creatorEmail),
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
