import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kickoff!",
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
                    Entry(Icons.calendar_month, " 18th April 2024", context),
                    SizedBox(height: 5,),
                    Entry(Icons.schedule, " 8:00 - 9:00 AM", context),
                    SizedBox(height: 3,),
                    Entry(Icons.pin_drop, " AB 1 Ground Floor", context),
                    SizedBox(height: 3,),
                  ],
                ),
              ),
              Text(
                "Tennis with the bois",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500, letterSpacing: 0.9),
              ),
            ],
          )),
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
