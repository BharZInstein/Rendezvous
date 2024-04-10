import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rendezvous/components/Bookingsite.dart';
import 'package:rendezvous/components/settings.dart';

import '../event.dart';
import 'eventcard.dart';
import 'navigationbar.dart';

class Homepage extends StatefulWidget {

  final User user;
  const Homepage({super.key, required this.user});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Event> events = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEventsData();
  }

  Future<void> _getEventsData() async {
    try {
      final collectionRef = _firestore.collection('events');

      // Fetch all documents using getDocs()
      final querySnapshot = await collectionRef.get();

      // Convert each document snapshot to an Event object
      setState(() {
        events = querySnapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
      });


    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rendezvous'),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(user: widget.user)))
                }, icon: Icon(Icons.home),
                  color: Theme.of(context).colorScheme.primary,
                ),
                IconButton(onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BookingPage(user: widget.user)))
                }, icon: Icon(Icons.add)),
                IconButton(onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountPage(user: widget.user)))
                }, icon: Icon(Icons.face))
              ],
            ),
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
                        widget.user.displayName!.split(' ')[0],
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
                      child: events.length == 0 ? Text("Loading") : EventCard(event: events[0]),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true, // Prevent the card from expanding unnecessarily
                              itemCount: events.length, // Replace with your array length
                              itemBuilder: (context, index) {
                                final card = events[index]; // Access each card object
                                // Replace this with your card's content based on the card data
                                return EventCard(event: card,);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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