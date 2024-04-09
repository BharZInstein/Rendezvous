import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'eventcard.dart';

class Event {
  final String title;
  final String description;

  const Event(this.title, this.description);
}

List<Event> getEvents() {
  return [
    Event("Cookoff", "Bring out your inner chef"),
    Event("Hackathon", "Code your way"),
    Event("TT", "Play your soul"),
  ];
}

Widget generateEventCard(
    String title, String description, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w500, letterSpacing: 0.9),
      ),
      SizedBox(height: 4),
      Entry(Icons.schedule, "9:00 - 10:00 AM", context),
      Divider()
    ],
  );
}

class Homepage extends StatefulWidget {

  final User user;
  const Homepage({super.key, required this.user});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    List<Event> events = getEvents();
    List<Widget> eventCards = [];
    for (var event in events) {
      eventCards
          .add(generateEventCard(event.title, event.description, context));
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rendezvous'),
        ),
        body: SingleChildScrollView(
          // Wrap content with SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTimeGreeting(),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                          letterSpacing: 0.001,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        "Abhinav",
                        style:
                        Theme.of(context).textTheme.displayMedium?.copyWith(
                          letterSpacing: 2.5,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Label(Icons.upcoming, " Coming up", context),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: EventCard(),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Label(Icons.event_note, " Followed by", context),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: eventCards,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Label(IconData iconData, String text, BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      color: Theme.of(context).colorScheme.secondary,
    );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          iconData,
          size: textStyle.fontSize!,
          color: textStyle.color,
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
  String getTimeGreeting() {
    var now = DateTime.now();
    int hour = now.hour;

    if (hour < 5) {
      return 'Hey There';
    } else if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}