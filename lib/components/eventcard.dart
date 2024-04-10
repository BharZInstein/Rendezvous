import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rendezvous/components/infopage.dart';

import '../event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({
    super.key,
    required this.event
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => InformationPage(event: event)))
      },
      child: Card(
        elevation: 10.0,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event.title}",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: Theme.of(context).colorScheme.primary
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6,),
                      Entry(Icons.calendar_month, " ${event.date}", context),
                      SizedBox(height: 5,),
                      Entry(Icons.schedule, " ${event.startTime} - ${event.endTime}", context),
                      SizedBox(height: 3,),
                      Entry(Icons.pin_drop, " ${event.area}", context),
                      SizedBox(height: 3,),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }


}
Widget Entry(IconData iconData, String text, BuildContext context) {
  TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
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
