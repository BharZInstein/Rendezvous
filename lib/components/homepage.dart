import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'eventcard.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rendezvous'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Up Next",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        letterSpacing: 1.1,
                      ),
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: EventCard(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
